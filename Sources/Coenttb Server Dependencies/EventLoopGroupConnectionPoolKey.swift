//
//  EventLoopGroupConnectionPoolKey.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 04-01-2024.
//

import Dependencies
@preconcurrency import PostgresKit

extension DependencyValues {
    public var eventLoopGroupConnectionPool: EventLoopGroupConnectionPool<PostgresConnectionSource> {
        get { self[EventLoopGroupConnectionPoolKey.self] }
        set { self[EventLoopGroupConnectionPoolKey.self] = newValue }
    }
}

public enum EventLoopGroupConnectionPoolKey: TestDependencyKey {
    public static var testValue: EventLoopGroupConnectionPool<PostgresConnectionSource> {
        liveValue
    }
}

extension EventLoopGroupConnectionPoolKey: DependencyKey {
    public static var liveValue: EventLoopGroupConnectionPool<PostgresConnectionSource> {
        @Dependency(\.mainEventLoopGroup) var mainEventLoopGroup
        @Dependency(\.sqlConfiguration) var sqlConfiguration
        
        return .init(
            source: PostgresConnectionSource(sqlConfiguration: sqlConfiguration),
            on: mainEventLoopGroup
        )
    }
}
