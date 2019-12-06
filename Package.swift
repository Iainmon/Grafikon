// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DrawKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        // .library(
        //     name: "GrafikonKit",
        //     targets: ["GrafikonKit"]),
        // .library(
        //     name: "DrawKit",
        //     targets: ["DrawKit"]),
        // .executable(
        //     name: "tool",
        //     targets: ["tool"]),
        // .executable(
        //     name: "DKApplication",
        //     targets: ["DKApplication"]),
        // .executable(
        //     name: "GKApplication",
        //     targets: ["GKApplication"]),
        .executable(
            name: "GLTestTool",
            targets: ["GLTestTool"]),
        
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGL/OpenGL.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGL/Math.git", from: "2.0.0"),
        .package(url: "https://github.com/SwiftGL/Image.git", from: "2.0.0"),
        .package(url: "https://github.com/Iainmon/CGLFW3.git", from: "2.0.1")
    ],
    targets: [
        // .target(
        //     name: "GrafikonKit",
        //     dependencies: [
        //         "SGLOpenGL",
        //         "SGLImage",
        //         "SGLMath",
        //     ]),
        // .target(
        //     name: "DrawKit",
        //     dependencies: [
        //         "SGLOpenGL",
        //         "SGLImage",
        //         "SGLMath",
        //         "GrafikonKit",
        //     ]),
        // .target(
        //     name: "tool",
        //     dependencies: ["DrawKit"]),
        // .target(
        //     name: "DKApplication",
        //     dependencies: ["DrawKit"]),
        .target(
            name: "GLTestTool",
            dependencies: [
                "SGLOpenGL",
                "SGLImage",
                "SGLMath",
            ]),
        // .target(
        //     name: "GKApplication",
        //     dependencies: ["GrafikonKit"]),
        // .testTarget(
        //     name: "GrafikonKitTests",
        //     dependencies: ["GrafikonKit"]),
        // .testTarget(
        //     name: "DrawKitTests",
        //     dependencies: ["DrawKit"]),
    ]
)
