// swift-tools-version:5.0

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
            .target(name: "CSQLite"),
            .product(name: "Logging", package: "swift-log")
        ]),
        .target(name: "CSQLite"),
        .testTarget(name: "SQLiteTests", dependencies: [
            .target(name: "SQLite")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
