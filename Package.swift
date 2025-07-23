// swift-tools-version:6.0

import PackageDescription

extension String {
    static let coenttbServer: Self = "Coenttb Server"
    static let coenttbServerRouter: Self = "Coenttb Server Router"
    static let coenttbServerEnvVars: Self = "Coenttb Server EnvVars"
    static let coenttbServerDependencies: Self = "Coenttb Server Dependencies"
    static let coenttbServerUtils: Self = "Coenttb Server Utils"
    static let coenttbDatabase: Self = "Coenttb Database"
}

extension Target.Dependency {
    static var coenttbServer: Self { .target(name: .coenttbServer) }
    static var coenttbServerEnvVars: Self { .target(name: .coenttbServerEnvVars) }
    static var coenttbServerDependencies: Self { .target(name: .coenttbServerDependencies) }
    static var coenttbDatabase: Self { .target(name: .coenttbDatabase) }
    static var coenttbServerUtils: Self { .target(name: .coenttbServerUtils) }
    static var coenttbServerRouter: Self { .target(name: .coenttbServerRouter) }
}

extension Target.Dependency {
    static var asyncHttpClient: Self { .product(name: "AsyncHTTPClient", package: "async-http-client") }
    static var casePaths: Self { .product(name: "CasePaths", package: "swift-case-paths") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var environmentVariables: Self { .product(name: "EnvironmentVariables", package: "swift-environment-variables") }
    static var languages: Self { .product(name: "Languages", package: "swift-language") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var rateLimiter: Self { .product(name: "RateLimiter", package: "coenttb-utils") }
    static var postgresKit: Self { .product(name: "PostgresKit", package: "postgres-kit") }
    static var issueReporting: Self { .product(name: "IssueReporting", package: "xctest-dynamic-overlay") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
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
                .coenttbServerDependencies,
                .coenttbDatabase,
                .coenttbServerUtils,
                .coenttbServerRouter
            ]
        ),
        .library(name: .coenttbServerEnvVars, targets: [.coenttbServerEnvVars]),
        .library(name: .coenttbServerDependencies, targets: [.coenttbServerDependencies]),
        .library(name: .coenttbDatabase, targets: [.coenttbDatabase]),
        .library(name: .coenttbServerUtils, targets: [.coenttbServerUtils]),
        .library(name: .coenttbServerRouter, targets: [.coenttbServerRouter])
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/coenttb-utils", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-language", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-environment-variables", branch: "main"),
        .package(url: "https://github.com/pointfreeco/swift-case-paths", from: "1.5.6"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.4.3"),
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.2"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.26.1"),
        .package(url: "https://github.com/vapor/postgres-kit", from: "2.12.0"),
        .package(url: "https://github.com/apple/swift-log", from: "1.0.0")
    ],
    targets: [
        .target(
            name: .coenttbServer,
            dependencies: [
                .coenttbServerEnvVars,
                .coenttbServerDependencies,
                .coenttbDatabase,
                .coenttbServerUtils,
                .coenttbServerRouter,
                .rateLimiter
            ]
        ),
        .target(
            name: .coenttbServerEnvVars,
            dependencies: [
                .environmentVariables,
                .logging
            ]
        ),
        .target(
            name: .coenttbServerDependencies,
            dependencies: [
                .asyncHttpClient,
                .dependencies,
                .postgresKit,
                .issueReporting,
                .logging
            ]
        ),
        .target(
            name: .coenttbServerUtils,
            dependencies: [
                .logging
            ]
        ),
        .target(
            name: .coenttbDatabase,
            dependencies: [
                .languages
            ]
        ),
        .target(
            name: .coenttbServerRouter,
            dependencies: [
                .coenttbServerDependencies,
                .casePaths,
                .dependencies,
                .languages,
                .urlRouting
            ]
        ),
        .testTarget(
            name: .coenttbServerDependencies.tests,
            dependencies: [
                .coenttbServerDependencies,
                .dependenciesTestSupport
            ]
        ),
        .testTarget(
            name: .coenttbDatabase.tests,
            dependencies: [
                .coenttbDatabase,
                .dependenciesTestSupport
            ]
        ),
        .testTarget(
            name: .coenttbServerEnvVars.tests,
            dependencies: [
                .coenttbServerEnvVars,
                .dependenciesTestSupport
            ]
        ),
        .testTarget(
            name: .coenttbServerRouter.tests,
            dependencies: [
                .coenttbServerRouter,
                .dependenciesTestSupport
            ]
        ),
        .testTarget(
            name: .coenttbServerUtils.tests,
            dependencies: [
                .coenttbServerUtils,
                .dependenciesTestSupport
            ]
        )

    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
