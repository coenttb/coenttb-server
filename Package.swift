// swift-tools-version:6.0

import PackageDescription

extension String {
    static let coenttbServer: Self = "Coenttb Server"
    static let coenttbServerRouter: Self = "Coenttb Server Router"
    static let coenttbServerEnvVars: Self = "Coenttb Server EnvVars"
    static let coenttbServerDependencies: Self = "Coenttb Server Dependencies"
    static let coenttbDatabase: Self = "Coenttb Database"
}

extension Target.Dependency {
    static var coenttbServer: Self { .target(name: .coenttbServer) }
    static var coenttbServerEnvVars: Self { .target(name: .coenttbServerEnvVars) }
    static var coenttbServerDependencies: Self { .target(name: .coenttbServerDependencies) }
    static var coenttbDatabase: Self { .target(name: .coenttbDatabase) }
    static var coenttbServerRouter: Self { .target(name: .coenttbServerRouter) }
}

extension Target.Dependency {
    static var serverFoundation: Self { .product(name: "ServerFoundation", package: "swift-server-foundation") }
    static var serverFoundationEnvVars: Self { .product(name: "ServerFoundationEnvVars", package: "swift-server-foundation") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
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
                .coenttbServerRouter
            ]
        ),
        .library(name: .coenttbServerEnvVars, targets: [.coenttbServerEnvVars]),
        .library(name: .coenttbServerDependencies, targets: [.coenttbServerDependencies]),
        .library(name: .coenttbDatabase, targets: [.coenttbDatabase]),
        .library(name: .coenttbServerRouter, targets: [.coenttbServerRouter])
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-server-foundation", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-translating", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-environment-variables", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-password-validation", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-url-routing-translating", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-ratelimiter", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-foundation-extensions", from: "0.1.0"),
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
                .coenttbServerRouter,
                .serverFoundation,
                .serverFoundationEnvVars
            ]
        ),
        .testTarget(
            name: .coenttbServer.tests,
            dependencies: [
                .coenttbServer,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .coenttbServerEnvVars,
            dependencies: [
                .serverFoundationEnvVars
            ]
        ),
        .target(
            name: .coenttbServerDependencies,
            dependencies: [
                .serverFoundation
            ]
        ),
        .target(
            name: .coenttbDatabase,
            dependencies: [
                .serverFoundation
            ]
        ),
        .target(
            name: .coenttbServerRouter,
            dependencies: [
                .coenttbServerDependencies,
                .serverFoundation
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
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
