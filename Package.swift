// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StoryKit-visionOS",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StoryKit-visionOS",
            targets: ["StoryKit-lib"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(name: "StoryKit-lib", url: "https://github.com/story-platform/StoryKit-visionOS/releases/download/v1.0.1/StoryKit.xcframework.zip", checksum: "633434474cd4d5de40c5d04c98e3fbf6b96146504b8a18d773f762030e44af4c")
    ]
)

