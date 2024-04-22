// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SZTextView",
    products: [
        .library(
            name: "SZTextView",
            targets: ["SZTextView"]),
    ],
    targets: [
        .target(
            name: "SZTextView",
            path: "SZTextView",
            exclude: ["Info.plist"],
            sources: ["Sources"],
            publicHeadersPath: "Sources")
    ]
)
