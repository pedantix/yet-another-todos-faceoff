// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "vapor_todos",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0-rc"),

        /// 💻 APIs for creating interactive CLI tools.
         .package(url: "https://github.com/vapor/console.git", from: "3.0.0"),

        // Fakery
        .package(url: "https://github.com/vadymmarkov/Fakery.git", from: "3.3.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentPostgreSQL", "Vapor", "Command", "Fakery"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
