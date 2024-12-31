//
//  RequestTimer.swift
//  coenttb-web
//
//  Created by Coen ten Thije Boonkkamp on 13/12/2024.
//

import Foundation

public struct RequestTimer {
    private let startTime: DispatchTime
    
    public init() {
        self.startTime = DispatchTime.now()
    }
    
    public var milliseconds: Int64 {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - startTime.uptimeNanoseconds
        return Int64(nanoTime) / 1_000_000 // Convert nanoseconds to milliseconds
    }
    
    public var microseconds: Int64 {
        let end = DispatchTime.now()
        let nanoTime = end.uptimeNanoseconds - startTime.uptimeNanoseconds
        return Int64(nanoTime) / 1_000 // Convert nanoseconds to microseconds
    }
}
