//
//  PasswordValidation Tests.swift
//  coenttb-server
//
//  Created by Coen ten Thije Boonkkamp on 23/07/2025.
//

@testable import Coenttb_Database
import Testing
import Dependencies
import DependenciesTestSupport

@Suite(
    "Coenttb Database Tests",
    .dependency(\.passwordValidation, .default),
    .dependency(\.locale, .english)
)
struct CoenttbDatabaseTests {}
