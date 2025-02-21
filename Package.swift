// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SKLite",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SKLite",
            targets: ["SKLite"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/wuyu2015/XCTestDelayPrinter", from: "1.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SKLite",
            dependencies: ["SKLiteWrapper"]),
        .target(
            name: "SKLiteWrapper",
            path: "Sources/SKLiteWrapper",
            sources: ["include/SKLiteWrapper.h", "src/SKLiteWrapper.c"]
        ),
        .testTarget(
            name: "SKLiteTests",
            dependencies: ["SKLite", "XCTestDelayPrinter"]),
    ]
)
