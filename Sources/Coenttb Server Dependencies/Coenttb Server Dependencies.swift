//
//  File.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 31/07/2025.
//

import ServerFoundation
import ServerFoundationVapor

extension HTTPClient: @retroactive DependencyKey {
    public static var liveValue: HTTPClient { .default }
}

extension MainEventLoopGroup: @retroactive DependencyKey {
    public static var liveValue: any EventLoopGroup { multithreaded }
}

extension InMemoryStore: @retroactive DependencyKey {
    static public let liveValue: InMemoryStore = .init() // Default capacity of 1000
}
