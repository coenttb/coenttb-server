//
//  PointFree Server Tests.swift
//  pointfree-server
//
//  Created by Coen ten Thije Boonkkamp on 23/07/2025.
//

import Testing
import Foundation
import Dependencies
import AsyncHTTPClient
import NIOCore
import NIOEmbedded
import Logging
@testable import PointFree_Server

@Suite("PointFree Server Tests")
struct PointFreeServerTests {
    
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
    
    @Suite("EventLoopGroup Tests")
    struct EventLoopGroupTests {
        
        @Test("MainEventLoopGroup dependency is available")
        func mainEventLoopGroupDependencyIsAvailable() async throws {
            @Dependency(\.mainEventLoopGroup) var eventLoopGroup
            #expect(eventLoopGroup is EmbeddedEventLoop)
        }
        
        @Test("MainEventLoopGroup has test value")
        func mainEventLoopGroupHasTestValue() async throws {
            let testValue = MainEventLoopGroupKey.testValue
            #expect(testValue is EmbeddedEventLoop)
        }
        
        @Test("MainEventLoopGroup can be overridden")
        func mainEventLoopGroupCanBeOverridden() async throws {
            let customEventLoop = EmbeddedEventLoop()
            
            withDependencies {
                $0.mainEventLoopGroup = customEventLoop
            } operation: {
                @Dependency(\.mainEventLoopGroup) var eventLoopGroup
                #expect(eventLoopGroup === customEventLoop)
            }
        }
    }
    
    @Suite("HTTPClient Tests")
    struct HTTPClientTests {
        
        @Test("HTTPClient dependency is available")
        func httpClientDependencyIsAvailable() async throws {
            withDependencies {
                $0.mainEventLoopGroup = EmbeddedEventLoop()
            } operation: {
                @Dependency(\.httpClient) var httpClient
                #expect(httpClient.eventLoopGroup is EmbeddedEventLoop)
            }
        }
        
        @Test("HTTPClient uses shared event loop group")
        func httpClientUsesSharedEventLoopGroup() async throws {
            let customEventLoop = EmbeddedEventLoop()
            
            withDependencies {
                $0.mainEventLoopGroup = customEventLoop
            } operation: {
                @Dependency(\.httpClient) var httpClient
                #expect(httpClient.eventLoopGroup === customEventLoop)
            }
        }
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
}
