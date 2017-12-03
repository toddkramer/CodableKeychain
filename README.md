# CodableKeychain

![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/CodableKeychain/badge.png) [![Swift](https://img.shields.io/badge/swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platform](https://cocoapod-badges.herokuapp.com/p/CodableKeychain/badge.png) [![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Installation

> _Note:_ CodableKeychain requires Swift 4 (and [Xcode][] 9) or greater.
>
> Targets using CodableKeychain must support embedded Swift frameworks.

[Xcode]: https://developer.apple.com/xcode/downloads/

### Swift Package Manager

[Swift Package Manager](https://github.com/apple/swift-package-manager) is Apple's
official package manager for Swift frameworks. To install with Swift Package
Manager:

1. Add CodableKeychain to your Package.swift file:

```
import PackageDescription

let package = Package(
name: "MyAppTarget",
dependencies: [
.Package(url: "https://github.com/toddkramer/CodableKeychain",
majorVersion: 0, minor: 4)
]
)
```

2. Run `swift build`.

3. Generate Xcode project:

```
swift package generate-xcodeproj
```


### Carthage

[Carthage][] is a decentralized dependency manager for Cocoa projects. To
install CodableKeychain with Carthage:

1. Make sure Carthage is [installed][Carthage Installation].

2. Add CodableKeychain to your Cartfile:

```
github "toddkramer/CodableKeychain" ~> 0.4.0
```

3. Run `carthage update` and [add the appropriate framework][Carthage Usage].


[Carthage]: https://github.com/Carthage/Carthage
[Carthage Installation]: https://github.com/Carthage/Carthage#installing-carthage
[Carthage Usage]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application


### CocoaPods

[CocoaPods][] is a centralized dependency manager for Cocoa projects. To install
CodableKeychain with CocoaPods:

1. Make sure the latest version of CocoaPods is [installed](https://guides.cocoapods.org/using/getting-started.html#getting-started).


2. Add CodableKeychain to your Podfile:

``` ruby
use_frameworks!

pod 'CodableKeychain', '~> 0.4.0'
```

3. Run `pod install`.

[CocoaPods]: https://cocoapods.org

