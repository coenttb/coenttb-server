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
}

extension Target.Dependency {
    static var serverFoundation: Self { .product(name: "ServerFoundation", package: "swift-server-foundation") }
    static var serverFoundationEnvVars: Self { .product(name: "ServerFoundationEnvVars", package: "swift-server-foundation") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var language: Self { .product(name: "Language", package: "swift-translating") }
    static var tagged: Self { .product(name: "Tagged", package: "swift-tagged") }
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
            ]
        ),
        .library(name: .coenttbServerEnvVars, targets: [.coenttbServerEnvVars]),
        .library(name: .coenttbServerDependencies, targets: [.coenttbServerDependencies]),
        .library(name: .coenttbDatabase, targets: [.coenttbDatabase]),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-server-foundation", branch: "main"),
        .package(url: "https://github.com/coenttb/swift-translating", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),
        .package(url: "https://github.com/pointfreeco/swift-tagged", from: "0.10.0"),
    ],
    targets: [
        .target(
            name: .coenttbServer,
            dependencies: [
                .coenttbServerEnvVars,
                .coenttbServerDependencies,
                .coenttbDatabase,
                .serverFoundation,
                .serverFoundationEnvVars,
                .tagged
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
                .serverFoundationEnvVars,
                .language
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
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
