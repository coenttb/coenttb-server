//
//  File.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 03/03/2025.
//

import Foundation
// Helper extension to provide context-specific error
extension URLError {
    static func badURL(reason: String) -> URLError {
        return URLError(.badURL, userInfo: ["reason": reason])
    }
}

