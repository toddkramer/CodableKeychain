
public struct KeychainAttributes {

    public let account: String
    public let service: String
    public let accessGroup: String?

    public init(account: String, service: String = Keychain.defaultService, accessGroup: String? = nil) {
        self.account = account
        self.service = service
        self.accessGroup = accessGroup
    }

}
