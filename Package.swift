// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FXLayoutViewKit",
    platforms: [
        .iOS(.v9)
    ],
    products: [
    .library(name: "FXLayoutViewKit", targets: ["FXLayoutViewKit"])
    ],
    targets: [
        .target(
            name: "FXLayoutViewKit",
            path: "Sources",
            publicHeadersPath: "."),
    ]
)
