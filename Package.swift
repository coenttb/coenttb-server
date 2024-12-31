// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let coenttbServer: Self = "Coenttb Server"
    static let coenttbServerRouter: Self = "Coenttb Server Router"
    static let coenttbServerEnvVars: Self = "Coenttb Server EnvVars"
    static let coenttbServerHTML: Self = "Coenttb Server HTML"
    static let coenttbServerDependencies: Self = "Coenttb Server Dependencies"
    static let coenttbServerModels: Self = "Coenttb Server Models"
    static let coenttbServerTranslations: Self = "Coenttb Server Translations"
    static let coenttbServerUtils: Self = "Coenttb Server Utils"
    static let coenttbDatabase: Self = "Coenttb Database"
}

extension Target.Dependency {
    static var coenttbServer: Self { .target(name: .coenttbServer) }
    static var coenttbServerEnvVars: Self { .target(name: .coenttbServerEnvVars) }
    static var coenttbServerHTML: Self { .target(name: .coenttbServerHTML) }
    static var coenttbServerDependencies: Self { .target(name: .coenttbServerDependencies) }
    static var coenttbServerModels: Self { .target(name: .coenttbServerModels) }
    static var coenttbServerTranslations: Self { .target(name: .coenttbServerTranslations) }
    static var coenttbDatabase: Self { .target(name: .coenttbDatabase) }
    static var coenttbServerUtils: Self { .target(name: .coenttbServerUtils) }
    static var coenttbServerRouter: Self { .target(name: .coenttbServerRouter) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "Coenttb Web", package: "coenttb-web") }
    static var coenttbWebEnvVars: Self { .product(name: "Coenttb Web EnvVars", package: "coenttb-web") }
    static var coenttbWebHTML: Self { .product(name: "Coenttb Web HTML", package: "coenttb-web") }
    static var coenttbWebDependencies: Self { .product(name: "Coenttb Web Dependencies", package: "coenttb-web") }
    static var coenttbWebModels: Self { .product(name: "Coenttb Web Models", package: "coenttb-web") }
    static var coenttbWebTranslations: Self { .product(name: "Coenttb Web Translations", package: "coenttb-web") }
    static var coenttbWebLegal: Self { .product(name: "Coenttb Web Legal", package: "coenttb-web") }
    static var coenttbWebUtils: Self { .product(name: "Coenttb Web Utils", package: "coenttb-web") }
    static var casePaths: Self { .product(name: "CasePaths", package: "swift-case-paths") }
    static var fluent: Self { .product(name: "Fluent", package: "fluent") }
    static var rateLimiter: Self { .product(name: "RateLimiter", package: "coenttb-utils") }
    static var postgresKit: Self { .product(name: "PostgresKit", package: "postgres-kit") }
    static var fluentPostgresDriver: Self { .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver") }
    static var issueReporting: Self { .product(name: "IssueReporting", package: "xctest-dynamic-overlay") }
    static var pointfreeServer: Self { .product(name: "PointFree Server", package: "pointfree-server") }
}

let package = Package(
    name: "coenttb-server",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: .coenttbServer,
            targets: [
                .coenttbServer,
                .coenttbServerEnvVars,
                .coenttbServerHTML,
                .coenttbServerDependencies,
                .coenttbServerModels,
                .coenttbServerTranslations,
                .coenttbDatabase,
                .coenttbServerUtils,
                .coenttbServerRouter,
            ]
        ),
        .library(name: .coenttbServerEnvVars, targets: [.coenttbServerEnvVars]),
        .library(name: .coenttbServerHTML, targets: [.coenttbServerHTML]),
        .library(name: .coenttbServerDependencies, targets: [.coenttbServerDependencies]),
        .library(name: .coenttbServerModels, targets: [.coenttbServerModels]),
        .library(name: .coenttbServerTranslations, targets: [.coenttbServerTranslations]),
        .library(name: .coenttbDatabase, targets: [.coenttbDatabase]),
        .library(name: .coenttbServerUtils, targets: [.coenttbServerUtils]),
        .library(name: .coenttbServerRouter, targets: [.coenttbServerRouter]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/coenttb-utils.git", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-web.git", branch: "main"),
        .package(url: "https://github.com/coenttb/pointfree-server.git", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", from: "1.5.6"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay.git", from: "1.4.3"),
        .package(url: "https://github.com/vapor/postgres-kit", from: "2.12.0"),
    ],
    targets: [
        .target(
            name: .coenttbServer,
            dependencies: [
                .coenttbWeb,
                .coenttbServerEnvVars,
                .coenttbServerHTML,
                .coenttbServerDependencies,
                .coenttbServerModels,
                .coenttbServerTranslations,
                .coenttbDatabase,
                .coenttbServerUtils,
            ]
        ),
        .target(
            name: .coenttbServerEnvVars,
            dependencies: [
                .coenttbWebEnvVars,
                .coenttbServerModels,
            ]
        ),
        .target(
            name: .coenttbServerHTML,
            dependencies: [
                .coenttbWeb,
                .coenttbServerTranslations,
                .coenttbServerDependencies,
            ]
        ),
        .target(
            name: .coenttbServerDependencies,
            dependencies: [
                .coenttbWeb,
                .coenttbServerModels,
                .postgresKit,
                .issueReporting,
                .pointfreeServer,
            ]
        ),
        .target(
            name: .coenttbServerUtils,
            dependencies: [
                .coenttbWebUtils
            ]
        ),
        .target(
            name: .coenttbServerModels,
            dependencies: [
                .coenttbWebModels,
            ]
        ),
        .target(
            name: .coenttbServerTranslations,
            dependencies: [
                .coenttbWebTranslations
            ]
        ),
        .target(
            name: .coenttbDatabase,
            dependencies: [
            ]
        ),
        .target(
            name: .coenttbServerRouter,
            dependencies: [
                .coenttbServerTranslations,
                .coenttbServerDependencies,
                .coenttbServerModels,
                .casePaths,
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
