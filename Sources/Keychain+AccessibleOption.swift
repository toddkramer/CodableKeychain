//
//  Keychain+AccessibleOption.swift
//
//  Copyright (c) 2017 Todd Kramer (http://www.tekramer.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Security

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
