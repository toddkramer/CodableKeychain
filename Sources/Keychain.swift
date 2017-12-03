
public final class Keychain {

    private enum Constants {
        static let accessible = kSecAttrAccessible.stringValue
        static let accessGroup = kSecAttrAccessGroup.stringValue
        static let account = kSecAttrAccount.stringValue
        static let `class` = kSecClass.stringValue
        static let matchLimit = kSecMatchLimit.stringValue
        static let returnData = kSecReturnData.stringValue
        static let service = kSecAttrService.stringValue
        static let valueData = kSecValueData.stringValue

        static let genericPassword = kSecClassGenericPassword.stringValue
        static let matchLimitOne = kSecMatchLimitOne.stringValue
    }

    public static let defaultService: String = Bundle.main.infoDictionary?[kCFBundleIdentifierKey.stringValue] as? String
        ?? "com.codablekeychain.service"

    public static let `default` = Keychain()

    // MARK: - Public

    public func store<T: KeychainStorable>(_ storable: T) throws {
        let newData = try JSONEncoder().encode(storable)
        var query = self.query(for: storable, isRetrieving: false)
        let existingData = try data(with: storable.keychainAttributes)
        var status = noErr
        let newAttributes: [String: Any] = [Constants.valueData: newData, Constants.accessible: storable.accessible.rawValue]
        if existingData != nil {
            status = SecItemUpdate(query as CFDictionary, newAttributes as CFDictionary)
        } else {
            query.merge(newAttributes) { $1 }
            status = SecItemAdd(query as CFDictionary, nil)
        }
        if let error = error(fromStatus: status) { throw error }
    }

    public func retrieveValue<T: KeychainStorable>(with attributes: KeychainAttributes) throws -> T? {
        guard let data = try data(with: attributes) else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }

    public func delete<T: KeychainStorable>(_ storable: T) throws {
        let query = self.query(with: storable.keychainAttributes, isRetrieving: false)
        let status = SecItemDelete(query as CFDictionary)
        if let error = error(fromStatus: status) { throw error }
    }

    // MARK: - Query

    func query(with attributes: KeychainAttributes, isRetrieving: Bool) -> [String: Any] {
        var query: [String: Any] = [
            Constants.service: attributes.service,
            Constants.class: Constants.genericPassword,
            Constants.account: attributes.account
        ]
        if let accessGroup = attributes.accessGroup {
            query[Constants.accessGroup] = accessGroup
        }
        if isRetrieving {
            query[Constants.matchLimit] = Constants.matchLimitOne
            query[Constants.returnData] = kCFBooleanTrue
        }
        return query
    }

    func query(for storable: KeychainStorable, isRetrieving: Bool) -> [String: Any] {
        var query = self.query(with: storable.keychainAttributes, isRetrieving: isRetrieving)
        query[Constants.accessible] = storable.accessible.rawValue
        return query
    }

    func data(with attributes: KeychainAttributes) throws -> Data? {
        let query = self.query(with: attributes, isRetrieving: true)
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        if let error = error(fromStatus: status), error != .itemNotFound { throw error }
        return result as? Data
    }

    func error(fromStatus status: OSStatus) -> KeychainError? {
        guard status != noErr && status != errSecSuccess else { return nil }
        return KeychainError(rawValue: Int(status)) ?? .unknown
    }

}
