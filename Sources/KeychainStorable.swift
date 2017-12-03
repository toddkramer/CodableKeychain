
public protocol KeychainStorable: Codable {

    var account: String { get }
    var service: String { get }
    var accessGroup: String? { get }
    var accessible: Keychain.AccessibleOption { get }

}

public extension KeychainStorable {

    var keychainAttributes: KeychainAttributes {
        return KeychainAttributes(account: account, service: service, accessGroup: accessGroup)
    }
    var service: String { return Keychain.defaultService }
    var accessGroup: String? { return nil }
    var accessible: Keychain.AccessibleOption { return .whenUnlocked }

}
