//
//  File.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 18/12/2024.
//

import Foundation
import Dependencies
import NIO

public struct DatabaseConfiguration: Sendable {
    public var maxConnectionsPerEventLoop: Int
    public var connectionPoolTimeout: TimeAmount
    
    public init(
        maxConnectionsPerEventLoop: Int,
        connectionPoolTimeout: TimeAmount
    ) {
        self.maxConnectionsPerEventLoop = maxConnectionsPerEventLoop
        self.connectionPoolTimeout = connectionPoolTimeout
    }
}


extension DatabaseConfiguration: TestDependencyKey {
    public static let testValue = DatabaseConfiguration(
        maxConnectionsPerEventLoop: 1,
        connectionPoolTimeout: .seconds(10)
    )
}

extension DatabaseConfiguration: DependencyKey {
    public static let liveValue = DatabaseConfiguration(
        maxConnectionsPerEventLoop: 1,
        connectionPoolTimeout: .seconds(10)
    )
}


extension DependencyValues {
    public var databaseConfiguration: DatabaseConfiguration {
        get { self[DatabaseConfiguration.self] }
        set { self[DatabaseConfiguration.self] = newValue }
    }
}
