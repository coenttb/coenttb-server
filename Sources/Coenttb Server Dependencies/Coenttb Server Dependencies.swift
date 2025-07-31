//
//  File.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 31/07/2025.
//

import ServerFoundation

extension HTTPClient: @retroactive DependencyKey {
    public static var liveValue: HTTPClient { .default }
}

extension DatabaseConfiguration: @retroactive DependencyKey {
    public static var liveValue: Self { .default }
}

extension MainEventLoopGroup: @retroactive DependencyKey {
    public static var liveValue: any EventLoopGroup { multithreaded }
}

extension EventLoopGroupConnectionPool<PostgresConnectionSource>: @retroactive DependencyKey {
    public static var liveValue: EventLoopGroupConnectionPool<PostgresConnectionSource> { .default }
}

extension InMemoryStore: @retroactive DependencyKey {
    static public let liveValue: InMemoryStore = .init() // Default capacity of 1000
}
