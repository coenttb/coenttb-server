//
//  DefaultRequestHandlerKey Tests.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 03/08/2025.
//

@testable import Coenttb_Server
import Dependencies
import Foundation
import IssueReporting
import IssueReportingTestSupport
import Logging
import Testing
import ServerFoundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@Suite(
    "DefaultRequestHandlerKey Tests"
)
struct DefaultRequestHandlerKeyTests {
    
    // MARK: - Test Models
    
    struct TestResponse: Codable, Equatable {
        let id: Int
        let message: String
        let createdAt: Date?
    }
    
    // Using Envelope from ServerFoundation package
    
    struct TestErrorResponse: Codable {
        let message: String
    }
    
    // MARK: - Helper Methods
    
    private func mockSession(data: Data, response: URLResponse) -> @Sendable (URLRequest) async throws -> (Data, URLResponse) {
        return { _ in (data, response) }
    }
    
    private func createTestEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private func mockHTTPResponse(statusCode: Int, url: URL = URL(string: "https://example.com")!) -> HTTPURLResponse {
        HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    private func createTestRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://api.example.com/test")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer token123", forHTTPHeaderField: "Authorization")
        return request
    }
    
    // MARK: - Initialization Tests
    
    @Test("Handler initializes with default values")
    func handlerInitializesWithDefaults() {
        let handler = URLRequest.Handler()
        
        #expect(handler.debug == false)
        // JSONDecoder strategies don't implement Equatable, so we test functionality instead
        // Just verify the decoder exists (it's not optional, so this is mainly for clarity)
        #expect(handler.decoder is JSONDecoder)
    }
    
    @Test("Handler initializes with custom values")
    func handlerInitializesWithCustomValues() {
        let customDecoder = JSONDecoder()
        customDecoder.dateDecodingStrategy = .millisecondsSince1970
        
        let handler = URLRequest.Handler(debug: true, decoder: customDecoder)
        
        #expect(handler.debug == true)
        #expect(handler.decoder === customDecoder)
    }
    
    @Test("Default decoder works with ISO8601 dates and snake_case")
    func defaultDecoderWorksWithISO8601DatesAndSnakeCase() throws {
        let decoder = URLRequest.Handler.defaultDecoder
        
        let jsonString = """
        {
            "created_at": "2023-01-01T12:00:00Z",
            "test_value": "success"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        struct TestModel: Codable {
            let createdAt: Date
            let testValue: String
        }
        
        let result = try decoder.decode(TestModel.self, from: jsonData)
        #expect(result.testValue == "success")
    }
    
    // MARK: - Successful Response Tests
    
    @Test("Handler decodes direct JSON response successfully")
    func handlerDecodesDirectJSONResponseSuccessfully() async throws {
        let testData = TestResponse(id: 1, message: "test", createdAt: Date())
        let jsonData = try createTestEncoder().encode(testData)
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            let result = try await handler(for: request, decodingTo: TestResponse.self)
            
            #expect(result.id == testData.id)
            #expect(result.message == testData.message)
        }
    }
    
    @Test("Handler decodes envelope response successfully")
    func handlerDecodesEnvelopeResponseSuccessfully() async throws {
        let testData = TestResponse(id: 2, message: "envelope test", createdAt: nil)
        let envelope = Envelope(success: true, data: testData, message: nil)
        let jsonData = try createTestEncoder().encode(envelope)
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            let result = try await handler(for: request, decodingTo: TestResponse.self)
            
            #expect(result.id == testData.id)
            #expect(result.message == testData.message)
        }
    }
    
    @Test("Handler handles void requests successfully")
    func handlerHandlesVoidRequestsSuccessfully() async throws {
        let response = mockHTTPResponse(statusCode: 204)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: Data(), response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            try await handler(for: request)
            // If we reach here without throwing, the test passes
        }
    }
    
    // MARK: - Error Handling Tests
    
    @Test("Handler throws RequestError.invalidResponse for non-HTTP response")
    func handlerThrowsInvalidResponseForNonHTTPResponse() async throws {
        let response = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: Data(), response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            await #expect(throws: RequestError.invalidResponse) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    @Test("Handler throws RequestError.httpError for 4xx status codes")
    func handlerThrowsHTTPErrorFor4xxStatusCodes() async throws {
        let errorMessage = "Not found"
        let errorResponse = TestErrorResponse(message: errorMessage)
        let jsonData = try JSONEncoder().encode(errorResponse)
        let response = mockHTTPResponse(statusCode: 404)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            await #expect(throws: RequestError.httpError(statusCode: 404, message: errorMessage)) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    @Test("Handler throws RequestError.httpError for 5xx status codes")
    func handlerThrowsHTTPErrorFor5xxStatusCodes() async throws {
        let errorMessage = "Internal server error"
        let errorResponse = TestErrorResponse(message: errorMessage)
        let jsonData = try JSONEncoder().encode(errorResponse)
        let response = mockHTTPResponse(statusCode: 500)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            await #expect(throws: RequestError.httpError(statusCode: 500, message: errorMessage)) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    @Test("Handler throws RequestError.envelopeDataMissing when envelope has no data")
    func handlerThrowsEnvelopeDataMissingWhenEnvelopeHasNoData() async throws {
        let envelope = Envelope<TestResponse>(success: true, data: nil, message: "No data")
        let jsonData = try createTestEncoder().encode(envelope)
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            await #expect(throws: RequestError.envelopeDataMissing) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    @Test("Handler throws RequestError.decodingError for invalid JSON")
    func handlerThrowsDecodingErrorForInvalidJSON() async throws {
        let invalidData = "invalid json".data(using: .utf8)!
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: invalidData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            await #expect(throws: RequestError.self) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    @Test("Handler handles network errors appropriately")
    func handlerHandlesNetworkErrorsAppropriately() async throws {
        let request = createTestRequest()
        
        try await withDependencies {
            $0.defaultSession = { _ in throw URLError(.networkConnectionLost) }
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            
            await #expect(throws: URLError.self) {
                try await handler(for: request, decodingTo: TestResponse.self)
            }
        }
    }
    
    // MARK: - Custom Decoder Tests
    
    @Test("Handler uses custom decoder configuration")
    func handlerUsesCustomDecoderConfiguration() async throws {
        let customDecoder = JSONDecoder()
        customDecoder.dateDecodingStrategy = .secondsSince1970
        customDecoder.keyDecodingStrategy = .convertFromSnakeCase // Need this for created_at -> createdAt
        
        let testDate = Date(timeIntervalSince1970: 1234567890)
        _ = TestResponse(id: 1, message: "test", createdAt: testDate)
        
        // Create JSON with seconds timestamp
        let jsonString = """
        {
            "id": 1,
            "message": "test",
            "created_at": 1234567890
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
            $0.defaultRequestHandler = URLRequest.Handler(decoder: customDecoder)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            let result = try await handler(for: request, decodingTo: TestResponse.self)
            
            #expect(result.id == 1)
            #expect(result.message == "test")
            #expect(result.createdAt?.timeIntervalSince1970 == 1234567890)
        }
    }
    
    // MARK: - Fallback Decoding Tests
    
    @Test("Handler falls back to direct decode when envelope decode fails")
    func handlerFallsBackToDirectDecodeWhenEnvelopeDecodeFails() async throws {
        let testData = TestResponse(id: 3, message: "fallback test", createdAt: nil)
        let jsonData = try createTestEncoder().encode(testData)
        let response = mockHTTPResponse(statusCode: 200)
        
        try await withDependencies {
            $0.defaultSession = mockSession(data: jsonData, response: response)
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            let request = createTestRequest()
            
            let result = try await handler(for: request, decodingTo: TestResponse.self)
            
            #expect(result.id == testData.id)
            #expect(result.message == testData.message)
        }
    }
    
    // MARK: - Debug Mode Tests
    
    @Test("Handler debug mode can be enabled")
    func handlerDebugModeCanBeEnabled() {
        let handler = URLRequest.Handler(debug: true)
        #expect(handler.debug == true)
    }
    
    @Test("Handler debug mode is disabled by default")
    func handlerDebugModeIsDisabledByDefault() {
        let handler = URLRequest.Handler()
        #expect(handler.debug == false)
    }
}

// MARK: - Error Types Tests

@Suite("RequestError Tests")
struct RequestErrorTests {
    
    @Test("RequestError.invalidResponse has correct description")
    func invalidResponseHasCorrectDescription() {
        let error = RequestError.invalidResponse
        #expect(error.localizedDescription == "Invalid response from server")
    }
    
    @Test("RequestError.httpError has correct description")
    func httpErrorHasCorrectDescription() {
        let error = RequestError.httpError(statusCode: 404, message: "Not found")
        #expect(error.localizedDescription == "HTTP error 404: Not found")
    }
    
    @Test("RequestError.decodingError has correct description")
    func decodingErrorHasCorrectDescription() {
        let context = DecodingContext(
            originalError: "JSON parsing failed",
            attemptedType: "TestModel",
            fileID: "TestFile.swift",
            line: 42
        )
        let error = RequestError.decodingError(context)
        #expect(error.localizedDescription.contains("Failed to decode response"))
        #expect(error.localizedDescription.contains("JSON parsing failed"))
    }
    
    @Test("RequestError.envelopeDataMissing has correct description")
    func envelopeDataMissingHasCorrectDescription() {
        let error = RequestError.envelopeDataMissing
        #expect(error.localizedDescription == "Envelope response contained no data")
    }
    
    @Test("DecodingContext creates correct description")
    func decodingContextCreatesCorrectDescription() {
        let context = DecodingContext(
            originalError: "Type mismatch",
            attemptedType: "User",
            fileID: "UserService.swift",
            line: 123
        )
        
        let description = context.description
        #expect(description.contains("Type mismatch"))
        #expect(description.contains("User"))
        #expect(description.contains("UserService.swift"))
        #expect(description.contains("123"))
    }
    
    @Test("DecodingContext includes raw data in description")
    func decodingContextIncludesRawDataInDescription() {
        let context = DecodingContext(
            originalError: "Invalid JSON",
            attemptedType: "Response",
            fileID: "APIClient.swift",
            line: 45,
            rawData: "{\"error\": \"Server unavailable\"}"
        )
        
        let description = context.description
        #expect(description.contains("Invalid JSON"))
        #expect(description.contains("Response"))
        #expect(description.contains("APIClient.swift"))
        #expect(description.contains("45"))
        #expect(description.contains("Raw data received: {\"error\": \"Server unavailable\"}"))
    }
    
    @Test("DecodingContext conforms to Equatable")
    func decodingContextConformsToEquatable() {
        let context1 = DecodingContext(
            originalError: "Error 1",
            attemptedType: "Type1",
            fileID: "File1.swift",
            line: 10
        )
        
        let context2 = DecodingContext(
            originalError: "Error 1",
            attemptedType: "Type1",
            fileID: "File1.swift",
            line: 10
        )
        
        let context3 = DecodingContext(
            originalError: "Error 2",
            attemptedType: "Type1",
            fileID: "File1.swift",
            line: 10
        )
        
        #expect(context1 == context2)
        #expect(context1 != context3)
    }
    
    @Test("RequestError conforms to Equatable")
    func requestErrorConformsToEquatable() {
        let error1 = RequestError.invalidResponse
        let error2 = RequestError.invalidResponse
        let error3 = RequestError.httpError(statusCode: 404, message: "Not found")
        let error4 = RequestError.httpError(statusCode: 404, message: "Not found")
        let error5 = RequestError.httpError(statusCode: 500, message: "Server error")
        
        #expect(error1 == error2)
        #expect(error3 == error4)
        #expect(error1 != error3)
        #expect(error3 != error5)
    }
}

// MARK: - Dependency Integration Tests

@Suite("DefaultRequestHandler Dependency Tests")
struct DefaultRequestHandlerDependencyTests {
    
    @Test("Handler is available as dependency")
    func handlerIsAvailableAsDependency() {
        @Dependency(\.defaultRequestHandler) var handler
        
        #expect(handler.debug == true) // test value default
    }
    
    @Test("Test value has debug enabled")
    func testValueHasDebugEnabled() {
        let testHandler = URLRequest.Handler.testValue
        #expect(testHandler.debug == true)
    }
    
    @Test("Live value has debug disabled")
    func liveValueHasDebugDisabled() {
        let liveHandler = URLRequest.Handler.liveValue
        #expect(liveHandler.debug == false)
    }
    
    @Test("Handler can be overridden in dependencies")
    func handlerCanBeOverriddenInDependencies() {
        let customHandler = URLRequest.Handler(debug: true)
        
        withDependencies {
            $0.defaultRequestHandler = customHandler
        } operation: {
            @Dependency(\.defaultRequestHandler) var handler
            #expect(handler.debug == true)
        }
    }
}
