// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "tuproq-sqlite",
    products: [
        .library(name: "SQLite", targets: ["SQLite"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "SQLite", dependencies: [
            .product(name: "Logging", package: "swift-log")
        ]),
        .testTarget(name: "SQLiteTests", dependencies: [
            .target(name: "SQLite")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
