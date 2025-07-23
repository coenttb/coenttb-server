//
//  EventLoopGroupConnectionPoolKey.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 04-01-2024.
//

import Dependencies
@preconcurrency import PostgresKit

enum EventLoopGroupConnectionPoolKey {}

extension DependencyValues {
    public var eventLoopGroupConnectionPool: EventLoopGroupConnectionPool<PostgresConnectionSource> {
        get { self[EventLoopGroupConnectionPoolKey.self] }
        set { self[EventLoopGroupConnectionPoolKey.self] = newValue }
    }
}

extension EventLoopGroupConnectionPoolKey: DependencyKey {
    public static var testValue: EventLoopGroupConnectionPool<PostgresConnectionSource> { .default }
    public static var liveValue: EventLoopGroupConnectionPool<PostgresConnectionSource> { .default }
}

extension EventLoopGroupConnectionPool<PostgresConnectionSource> {
    static var `default`: Self {
        @Dependency(\.mainEventLoopGroup) var mainEventLoopGroup
        @Dependency(\.sqlConfiguration) var sqlConfiguration

        return .init(
            source: PostgresConnectionSource(sqlConfiguration: sqlConfiguration),
            on: mainEventLoopGroup
        )
    }
}
