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
        //.package(name: "JHThird", url: "http://192.168.9.190/publicplugingoup/JHThirdPackage.git", .branch("master"))
    ],
    targets: [
        //.target(name: "JHBase", dependencies: [
        //    .product(name: "SnapKit", package: "JHThird"),
        //    .product(name: "Alamofire", package: "JHThird"),
        //    .product(name: "SwifterSwift", package: "JHThird"),
        //], path: "JHBase"),
        .binaryTarget(name: "JHBase",
                      path: "XCFrameworks/JHBase.xcframework"),
    ],
    swiftLanguageVersions: [.v5]
)
