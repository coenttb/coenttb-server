//
//  pointfreeco/pointfreeco/Sources/PointFree/Environment.swift
//
//
//  Created by PointFree
//

import Coenttb_Web
import PointFree_Server

extension MainEventLoopGroupKey: @retroactive DependencyKey {
    public static var liveValue: any EventLoopGroup {
#if DEBUG
        return MultiThreadedEventLoopGroup(numberOfThreads: 1)
#else
        return MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
#endif
    }
}
