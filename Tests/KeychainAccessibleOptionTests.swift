//
//  KeychainAccessibleOptionTests.swift
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

