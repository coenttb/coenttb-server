//
//  Logger Tests.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 23/07/2025.
//

@testable import Coenttb_Server_Dependencies
import Testing

@Suite("Logger Tests")
struct LoggerTests {

    //        @Test("Logger dependency is available")
    //        func loggerDependencyIsAvailable() async throws {
    //            withDependencies {
    //                0.logger = Logger(label: "test")
    //            } operation: {
    //                @Dependency(\.logger) var logger
    //                #expect(logger.label == "test")
    //            }
    //        }
    //
    //        @Test("Logger has test value")
    //        func loggerHasTestValue() async throws {
    //            @Dependency(\.logger) var logger
    //            #expect(logger.label == ProcessInfo.processInfo.processName)
    //        }
    //
    //        @Test("Logger log method includes file and line metadata")
    //        func loggerLogMethodIncludesMetadata() async throws {
    //            var capturedMetadata: Logger.Metadata?
    //
    //            let mockLogger = Logger(label: "test") { level, message, metadata, source, file, function, line in
    //                capturedMetadata = metadata
    //            }
    //
    //            withDependencies {
    //                $0.logger = mockLogger
    //            } operation: {
    //                @Dependency(\.logger) var logger
    //                logger.log(.info, "test message", file: "TestFile.swift", line: 42)
    //            }
    //
    //            #expect(capturedMetadata?["file"] as? String == "TestFile.swift")
    //            #expect(capturedMetadata?["line"] as? String == "42")
    //        }
}

@Suite("Integration Tests")
struct IntegrationTests {

    @Test("All dependencies work together")
    func allDependenciesWorkTogether() async throws {
        let eventLoop = EmbeddedEventLoop()
        let logger = Logger(label: "integration-test")

        withDependencies {
            $0.mainEventLoopGroup = eventLoop
            $0.logger = logger
        } operation: {
            @Dependency(\.mainEventLoopGroup) var eventLoopGroup
            @Dependency(\.logger) var testLogger
            @Dependency(\.httpClient) var httpClient

            #expect(eventLoopGroup === eventLoop)
            #expect(testLogger.label == "integration-test")
            #expect(httpClient.eventLoopGroup === eventLoop)
        }
    }
}
