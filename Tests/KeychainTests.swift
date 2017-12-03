//
//  KeychainTests.swift
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

struct Credential: KeychainStorable {
    let email: String
    let password: String
    let pin: Int
    let dob: Date
}

extension Credential {

    var account: String { return email }

}

class KeychainTests: XCTestCase {

    private enum Email {
        static let test = "test@example.com"
        static let newUser = "newuser@example.com"
    }

    let keychain = Keychain.default
    let credential = Credential(email: Email.test, password: "foobar", pin: 1234, dob: Date(timeIntervalSince1970: 1000))
    let updatedCredential = Credential(email: Email.test, password: "newpassword", pin: 1357, dob: Date(timeIntervalSince1970: 2000))
    let credentialTwo = Credential(email: Email.newUser, password: "password", pin: 5678, dob: Date(timeIntervalSince1970: 3000))
    
    override func tearDown() {
        cleanup()
        super.tearDown()
    }

    func cleanup() {
        do {
            let credentials = [credential, credentialTwo]
            try credentials.forEach {
                try keychain.delete($0)
            }
        } catch let error {
            guard let error = error as? KeychainError else { XCTFail(); return }
            XCTAssertEqual(error, KeychainError.itemNotFound)
        }
    }

    func testSaveValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
    }

    func testRetrieveValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
        let retrievedValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.email, credential.email)
        XCTAssertEqual(retrievedValue?.password, credential.password)
        XCTAssertEqual(retrievedValue?.pin, credential.pin)
        XCTAssertEqual(retrievedValue?.dob, credential.dob)
    }

    func testUpdateValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
        let retrievedValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.email, credential.email)
        XCTAssertEqual(retrievedValue?.password, credential.password)
        XCTAssertEqual(retrievedValue?.pin, credential.pin)
        XCTAssertEqual(retrievedValue?.dob, credential.dob)
        XCTAssertNoThrow(try keychain.store(updatedCredential))
        let updatedValue: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNotNil(updatedValue)
        XCTAssertEqual(updatedValue?.email, credential.email)
        XCTAssertEqual(updatedValue?.password, updatedCredential.password)
        XCTAssertEqual(updatedValue?.pin, updatedCredential.pin)
        XCTAssertEqual(updatedValue?.dob, updatedCredential.dob)
    }

    func testMultipleAccounts() {
        XCTAssertNoThrow(try keychain.store(credential))
        XCTAssertNoThrow(try keychain.store(credentialTwo))
        let retrievedOne: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        let retrievedTwo: Credential? = try! keychain.retrieveValue(with: credential.keychainAttributes)
        XCTAssertNotNil(retrievedOne)
        XCTAssertNotNil(retrievedTwo)
    }

    func testDeleteUnsavedValue() {
        XCTAssertThrowsError(try keychain.delete(credential))
    }

    func testStoreQuery() {
        let accessGroup = "com.test.accessGroup"
        let attributes = KeychainAttributes(account: Email.test, service: Keychain.defaultService, accessGroup: accessGroup)
        let query = keychain.query(with: attributes, isRetrieving: false) as! [String: String]
        let expectedQuery: [String: String] = [
            kSecAttrService.stringValue: Keychain.defaultService,
            kSecClass.stringValue: kSecClassGenericPassword.stringValue,
            kSecAttrAccessGroup.stringValue: accessGroup,
            kSecAttrAccount.stringValue: Email.test
        ]
        XCTAssertEqual(query, expectedQuery)
    }

    func testUnknownError() {
        let status = OSStatus(12345)
        let error = keychain.error(fromStatus: status)
        XCTAssertEqual(error, .unknown)
    }
    
}
