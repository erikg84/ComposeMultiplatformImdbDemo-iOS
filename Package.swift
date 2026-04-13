// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ImdbSDKPackage",
    platforms: [.iOS(.v16)],
    dependencies: [
        .package(id: "dallaslabs-sdk.imdb-sdk", from: "1.0.6"),
    ],
    targets: []
)
