// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ImdbSDKPackage",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "ImdbSDK", targets: ["ImdbSDK"]),
    ],
    targets: [
        .binaryTarget(
            name: "ImdbSDK",
            url: "https://storage.googleapis.com/dallaslabs-sdk-artifacts/xcframework/ImdbSDK-1.0.5.xcframework.zip",
            checksum: "80c0689a6a8e652802228386d0e3433316a3fa8428e6bb5d20586c3f3825990d"
        ),
    ]
)
