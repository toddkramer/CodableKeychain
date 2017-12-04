# CodableKeychain

![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/CodableKeychain/badge.png) [![Swift](https://img.shields.io/badge/swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platform](https://cocoapod-badges.herokuapp.com/p/CodableKeychain/badge.png) [![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview

CodableKeychain is a Swift framework for saving objects conforming to the `Codable` protocol to the keychain.

## Usage

### KeychainStorable

The `KeychainStorable` protocol, which inherits from `Codable`, is used to define a model that can be stored using CodableKeychain.

> _Note:_ If you do not define a service or access group, CodableKeychain will default to your app's bundle identifier for the service and `nil` for the access group.

```swift
import CodableKeychain

enum Constants {
    static let accessGroup = "[APP_ID_PREFIX].com.example.TestKeychain"
    static let service = "com.example.credentialservice"
}

struct Credential: KeychainStorable {
    let email: String
    let password: String
    let pin: Int
    let dob: Date
}

extension Credential {

    var account: String { return email }
    var service: String { return Constants.service }
    var accessGroup: String? { return Constants.accessGroup }
    var accessible: Keychain.AccessibleOption { return .whenPasscodeSetThisDeviceOnly }

}
```

### Storing

```swift
let credential = Credential(email: "test@example.com", password: "foobar", pin: 1234, dob: Date(timeIntervalSince1970: 100000))
do {
    try Keychain.default.store(credential)
} catch let error {
    print(error)
}
```

### Retrieving

```swift
do {
    let attributes = KeychainAttributes(account: "test@example.com", service: Constants.service, accessGroup: Constants.accessGroup)
    let credential: Credential? = try Keychain.default.retrieveValue(with: attributes)
} catch let error {
    print(error)
}
```


## Installation

> _Note:_ CodableKeychain requires Swift 4 (and [Xcode][] 9) or greater.
>
> Targets using CodableKeychain must support embedded Swift frameworks.

[Xcode]: https://developer.apple.com/xcode/downloads/


### CocoaPods

[CocoaPods][] is a centralized dependency manager for Cocoa projects. To install
CodableKeychain with CocoaPods:

1. Make sure the latest version of CocoaPods is [installed](https://guides.cocoapods.org/using/getting-started.html#getting-started).


2. Add CodableKeychain to your Podfile:

``` ruby
use_frameworks!

pod 'CodableKeychain', '~> 0.5.0'
```

3. Run `pod install`.

[CocoaPods]: https://cocoapods.org


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
        .Package(url: "https://github.com/toddkramer/CodableKeychain", majorVersion: 0, minor: 5)
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
github "toddkramer/CodableKeychain" ~> 0.5.0
```

3. Run `carthage update` and [add the appropriate framework][Carthage Usage].


[Carthage]: https://github.com/Carthage/Carthage
[Carthage Installation]: https://github.com/Carthage/Carthage#installing-carthage
[Carthage Usage]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

