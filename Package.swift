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
    static let coenttbServerLegal: Self = "Coenttb Server Legal"

    static let coenttbDatabase: Self = "Coenttb Database"
    static let coenttbVapor: Self = "Coenttb Vapor"
}

extension Target.Dependency {
    static var coenttbServer: Self { .target(name: .coenttbServer) }
    static var coenttbServerEnvVars: Self { .target(name: .coenttbServerEnvVars) }
    static var coenttbServerHTML: Self { .target(name: .coenttbServerHTML) }
    static var coenttbServerDependencies: Self { .target(name: .coenttbServerDependencies) }
    static var coenttbServerModels: Self { .target(name: .coenttbServerModels) }
    static var coenttbServerTranslations: Self { .target(name: .coenttbServerTranslations) }
    static var coenttbVapor: Self { .target(name: .coenttbVapor) }
    static var coenttbDatabase: Self { .target(name: .coenttbDatabase) }
    static var coenttbServerLegal: Self { .target(name: .coenttbServerLegal) }
    static var coenttbServerUtils: Self { .target(name: .coenttbServerUtils) }
    static var coenttbServerRouter: Self { .target(name: .coenttbServerRouter) }
}

extension Target.Dependency {
    static var coenttbWeb: Self { .product(name: "CoenttbWeb", package: "coenttb-web") }
    static var coenttbWebEnvVars: Self { .product(name: "CoenttbWebEnvVars", package: "coenttb-web") }
    static var coenttbWebHTML: Self { .product(name: "CoenttbWebHTML", package: "coenttb-web") }
    static var coenttbWebDependencies: Self { .product(name: "CoenttbWebDependencies", package: "coenttb-web") }
    static var coenttbWebModels: Self { .product(name: "CoenttbWebModels", package: "coenttb-web") }
    static var coenttbWebTranslations: Self { .product(name: "CoenttbWebTranslations", package: "coenttb-web") }
    static var coenttbWebLegal: Self { .product(name: "CoenttbWebLegal", package: "coenttb-web") }
    static var coenttbWebUtils: Self { .product(name: "CoenttbWebUtils", package: "coenttb-web") }
}

extension Target.Dependency {
    static var environmentVariables: Self { .product(name: "EnvironmentVariables", package: "swift-environment-variables") }
    static var swiftWeb: Self { .product(name: "SwiftWeb", package: "swift-web") }
    static var coenttbEmail: Self { .product(name: "CoenttbEmail", package: "coenttb-html") }
    static var coenttbHtml: Self { .product(name: "CoenttbHTML", package: "coenttb-html") }
    static var coenttbMarkdown: Self { .product(name: "CoenttbMarkdown", package: "coenttb-html") }
    static var casePaths: Self { .product(name: "CasePaths", package: "swift-case-paths") }
    static var fluent: Self { .product(name: "Fluent", package: "fluent") }
    static var rateLimiter: Self { .product(name: "RateLimiter", package: "coenttb-utils") }
    static var language: Self { .product(name: "Languages", package: "swift-language") }
    static var postgresKit: Self { .product(name: "PostgresKit", package: "postgres-kit") }
    static var vapor: Self { .product(name: "Vapor", package: "vapor") }
    static var vaporRouting: Self { .product(name: "VaporRouting", package: "vapor-routing") }
    static var fluentPostgresDriver: Self { .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver") }
    static var issueReporting: Self { .product(name: "IssueReporting", package: "xctest-dynamic-overlay") }
}

let package = Package(
    name: "coenttb-server",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .coenttbServer, targets: [.coenttbServer]),
        .library(name: .coenttbServerEnvVars, targets: [.coenttbServerEnvVars]),
        .library(name: .coenttbServerHTML, targets: [.coenttbServerHTML]),
        .library(name: .coenttbServerDependencies, targets: [.coenttbServerDependencies]),
        .library(name: .coenttbServerModels, targets: [.coenttbServerModels]),
        .library(name: .coenttbServerTranslations, targets: [.coenttbServerTranslations]),
        .library(name: .coenttbVapor, targets: [.coenttbVapor]),
        .library(name: .coenttbDatabase, targets: [.coenttbDatabase]),
        .library(name: .coenttbServerUtils, targets: [.coenttbServerUtils]),
        .library(name: .coenttbServerLegal, targets: [.coenttbServerLegal]),
        .library(name: .coenttbServerRouter, targets: [.coenttbServerRouter]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-html", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-web", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-date", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-html", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-utils.git", branch: "main"),
        .package(url: "https://github.com/coenttb/coenttb-web.git", branch: "coenttb-server-extraction"),
        .package(url: "https://github.com/coenttb/swift-language.git", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-environment-variables.git", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.5"),
        .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.10.0"),
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
        .package(url: "https://github.com/pointfreeco/vapor-routing.git", from: "0.1.3"),
        .package(url: "https://github.com/pointfreeco/swift-sharing.git", from: "1.0.4"),
        .package(url: "https://github.com/pointfreeco/swift-case-paths.git", from: "1.5.6"),
        .package(url: "https://github.com/pointfreeco/swift-prelude.git", branch: "main"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay.git", from: "1.4.3"),
        .package(url: "https://github.com/vapor/postgres-kit", from: "2.12.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.7.2"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.102.1"),
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
                .coenttbVapor,
                .coenttbDatabase,
                .coenttbServerLegal,
                .coenttbServerUtils,
            ]
        ),
        .target(
            name: .coenttbServerEnvVars,
            dependencies: [
                .coenttbWebEnvVars,
                .coenttbServerModels,
                .environmentVariables,
            ]
        ),
        .target(
            name: .coenttbServerHTML,
            dependencies: [
                .swiftWeb,
                .coenttbWebHTML,
                .coenttbHtml,
                .coenttbMarkdown,
                .coenttbServerTranslations,
                .coenttbServerDependencies,
            ]
        ),
        .target(
            name: .coenttbServerLegal,
            dependencies: [
                .swiftWeb,
                .coenttbWebLegal,
                .coenttbServerHTML,
                .coenttbMarkdown,
                .coenttbServerTranslations,
                .coenttbHtml,
                .vapor,
            ]
        ),
        .target(
            name: .coenttbServerDependencies,
            dependencies: [
                .swiftWeb,
                .coenttbWebDependencies,
                .coenttbServerModels,
                .fluent,
                .postgresKit,
                .vapor,
                .issueReporting,
            ]
        ),
        .target(
            name: .coenttbServerUtils,
            dependencies: [
                .swiftWeb,
                .coenttbWebUtils
            ]
        ),
        .target(
            name: .coenttbServerModels,
            dependencies: [
                .swiftWeb,
                .coenttbWebModels,
                .fluent,
            ]
        ),
        .target(
            name: .coenttbServerTranslations,
            dependencies: [
                .language,
                .coenttbWebTranslations
            ]
        ),
        .target(
            name: .coenttbVapor,
            dependencies: [
                .swiftWeb,
                .coenttbServerDependencies,
                .coenttbServerRouter,
                .coenttbServerEnvVars,
                .vapor,
                .vaporRouting,
                .rateLimiter
            ]
        ),
        .target(
            name: .coenttbDatabase,
            dependencies: [
                .swiftWeb,
                .fluent,
                .fluentPostgresDriver,
            ]
        ),
        .target(
            name: .coenttbServerRouter,
            dependencies: [
                .language,
                .swiftWeb,
                .coenttbServerTranslations,
                .coenttbServerDependencies,
                .coenttbServerModels,
                .casePaths,
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
