// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "tuproq-sqlite",
    platforms: [
        .iOS(.v13),
        .macOS(.v12),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "SQLite", targets: ["SQLite"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(name: "tuproq-csqlite", url: "https://github.com/tuproq/csqlite.git", .branch("master"))
    ],
    targets: [
        .target(name: "SQLite", dependencies: [
            .product(name: "Logging", package: "swift-log"),
            .product(name: "CSQLite", package: "tuproq-csqlite")
        ]),
        .testTarget(name: "SQLiteTests", dependencies: [
            .target(name: "SQLite")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
