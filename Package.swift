// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "advent-of-code-2022",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "AOC",
      targets: ["AOC"])
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Quick.git", from: "5.0.0"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0"),
    .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "AOC",
      dependencies: ["BigInt"]),
    .testTarget(
      name: "AOCTests",
      dependencies: ["AOC", "Quick", "Nimble"]),
  ]
)
