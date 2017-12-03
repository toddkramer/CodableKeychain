
import XCTest
@testable import CodableKeychain

class KeychainAccessibleOptionTests: XCTestCase {

    struct Test {
        let input: CFString
        let output: Keychain.AccessibleOption
    }

    var tests: [Test] {
        return [
            Test(input: kSecAttrAccessibleAfterFirstUnlock, output: .afterFirstUnlock),
            Test(input: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, output: .afterFirstUnlockThisDeviceOnly),
            Test(input: kSecAttrAccessibleAlways, output: .always),
            Test(input: kSecAttrAccessibleAlwaysThisDeviceOnly, output: .alwaysThisDeviceOnly),
            Test(input: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, output: .whenPasscodeSetThisDeviceOnly),
            Test(input: kSecAttrAccessibleWhenUnlocked, output: .whenUnlocked),
            Test(input: kSecAttrAccessibleWhenUnlockedThisDeviceOnly, output: .whenUnlockedThisDeviceOnly)
        ]
    }

    func testAccessibleOptionInitialization() {
        tests.forEach {
            let output = Keychain.AccessibleOption(rawValue: $0.input.stringValue)
            XCTAssertEqual(output, $0.output)
        }
        let unknownAccessibleOption = Keychain.AccessibleOption(rawValue: "test")
        XCTAssertEqual(unknownAccessibleOption, .whenUnlocked)
    }

}

