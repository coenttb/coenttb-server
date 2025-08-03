//
//  HTTPClient Tests.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 23/07/2025.
//

@testable import Coenttb_Server_Dependencies
import Testing
import ServerFoundation

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
