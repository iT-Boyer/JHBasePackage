// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JHBase",
    platforms: [.iOS(.v12)],
    products: [
        //.library(name: "JHBase", type: .static, targets: ["JHBase"]),
        .library(name: "JHBase", targets: ["JHBase"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.3"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.1"),
      .package(url: "https://github.com/SwifterSwift/SwifterSwift.git", from: "5.3.0")
    ],
    targets: [
      .target(name: "JHBase",
              dependencies: ["SnapKit","Alamofire","SwifterSwift"],
              path: "JHBase"),
    ],
    swiftLanguageVersions: [.v5]
)
