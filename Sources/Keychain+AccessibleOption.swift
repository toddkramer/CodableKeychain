
extension Keychain {

    public enum AccessibleOption: RawRepresentable {

        private enum Constants {
            static let afterFirstUnlock = kSecAttrAccessibleAfterFirstUnlock.stringValue
            static let afterFirstUnlockThisDeviceOnly = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly.stringValue
            static let always = kSecAttrAccessibleAlways.stringValue
            static let alwaysThisDeviceOnly = kSecAttrAccessibleAlwaysThisDeviceOnly.stringValue
            static let whenPasscodeSetThisDeviceOnly = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly.stringValue
            static let whenUnlocked = kSecAttrAccessibleWhenUnlocked.stringValue
            static let whenUnlockedThisDeviceOnly = kSecAttrAccessibleWhenUnlockedThisDeviceOnly.stringValue
            
        }

        case afterFirstUnlock
        case afterFirstUnlockThisDeviceOnly
        case always
        case alwaysThisDeviceOnly
        case whenPasscodeSetThisDeviceOnly
        case whenUnlocked
        case whenUnlockedThisDeviceOnly

        public var rawValue: String {
            switch self {
            case .afterFirstUnlock:
                return Constants.afterFirstUnlock
            case .afterFirstUnlockThisDeviceOnly:
                return Constants.afterFirstUnlockThisDeviceOnly
            case .always:
                return Constants.always
            case .alwaysThisDeviceOnly:
                return Constants.alwaysThisDeviceOnly
            case .whenPasscodeSetThisDeviceOnly:
                return Constants.whenPasscodeSetThisDeviceOnly
            case .whenUnlocked:
                return Constants.whenUnlocked
            case .whenUnlockedThisDeviceOnly:
                return Constants.whenUnlockedThisDeviceOnly
            }
        }

        public init?(rawValue: String) {
            switch rawValue {
            case Constants.afterFirstUnlock:
                self = .afterFirstUnlock
            case Constants.afterFirstUnlockThisDeviceOnly:
                self = .afterFirstUnlockThisDeviceOnly
            case Constants.always:
                self = .always
            case Constants.alwaysThisDeviceOnly:
                self = .alwaysThisDeviceOnly
            case Constants.whenPasscodeSetThisDeviceOnly:
                self = .whenPasscodeSetThisDeviceOnly
            case Constants.whenUnlocked:
                self = .whenUnlocked
            case Constants.whenUnlockedThisDeviceOnly:
                self = .whenUnlockedThisDeviceOnly
            default:
                self = .whenUnlocked
            }
        }

    }

}
