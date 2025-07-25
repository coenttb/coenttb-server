//
//  EventLoopGroup Tests.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 23/07/2025.
//

@testable import Coenttb_Server_Dependencies
import Testing

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
