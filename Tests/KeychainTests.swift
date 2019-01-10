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

final class MockSecurityItemManager: SecurityItemManaging {

    var addError: KeychainError?
    var updateError: KeychainError?
    var deleteError: KeychainError?
    var copyMatchingError: KeychainError?

    private func status(for error: KeychainError?) -> OSStatus {
        guard let error = error else { return errSecSuccess }
        return OSStatus(error.rawValue)
    }

    func add(withAttributes attributes: [String : Any], result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return status(for: addError)
    }

    func update(withQuery query: [String : Any], attributesToUpdate: [String : Any]) -> OSStatus {
        return status(for: updateError)
    }

    func delete(withQuery query: [String : Any]) -> OSStatus {
        return status(for: deleteError)
    }

    func copyMatching(_ query: [String : Any], result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return status(for: copyMatchingError)
    }

}

struct Credential: KeychainStorable {
    let email: String
    let password: String
    let pin: Int
    let dob: Date
}

extension Credential {

    var account: String { return email }

}

struct Account: KeychainStorable {
    let username: String
    let password: String
}

extension Account {

    var account: String { return username }

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
    let account = Account(username: "test", password: "foobar")
    let accessGroup = "com.test.accessGroup"

    var defaultService: String {
        var defaultService: String
        #if os(iOS)
            defaultService = "com.toddkramer.MobileHost"
        #else
            defaultService = "com.codablekeychain.service"
        #endif
        return defaultService
    }
    
    override func tearDown() {
        cleanup()
        super.tearDown()
    }

    func cleanup() {
        Keychain.resetDefaults()
        do {
            let credentials = [credential, credentialTwo]
            try credentials.forEach {
                try keychain.delete($0)
            }
            try keychain.clearAll()
        } catch let error {
            guard let error = error as? KeychainError else { XCTFail(); return }
            XCTAssertEqual(error, KeychainError.itemNotFound)
        }
    }

    func testKeychainDefaults() {
        XCTAssertEqual(Keychain.defaultService, defaultService)
        XCTAssertNil(Keychain.defaultAccessGroup)
        Keychain.configureDefaults(withService: "com.service.test", accessGroup: "com.test.accessGroup")
        XCTAssertEqual(Keychain.defaultService, "com.service.test")
        XCTAssertEqual(Keychain.defaultAccessGroup, "com.test.accessGroup")
        Keychain.resetDefaults()
        XCTAssertEqual(Keychain.defaultService, defaultService)
        XCTAssertNil(Keychain.defaultAccessGroup)
    }

    func testStoreValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
    }

    func testStoreError() {
        let mockManager = MockSecurityItemManager()
        mockManager.addError = .missingEntitlement
        let keychain = Keychain(securityItemManager: mockManager)
        XCTAssertThrowsError(try keychain.store(credential))
    }

    func testRetrieveValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
        let retrievedValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.email, credential.email)
        XCTAssertEqual(retrievedValue?.password, credential.password)
        XCTAssertEqual(retrievedValue?.pin, credential.pin)
        XCTAssertEqual(retrievedValue?.dob, credential.dob)
    }

    func testUpdateValue() {
        let existingValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNil(existingValue)
        XCTAssertNoThrow(try keychain.store(credential))
        let retrievedValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNotNil(retrievedValue)
        XCTAssertEqual(retrievedValue?.email, credential.email)
        XCTAssertEqual(retrievedValue?.password, credential.password)
        XCTAssertEqual(retrievedValue?.pin, credential.pin)
        XCTAssertEqual(retrievedValue?.dob, credential.dob)
        XCTAssertNoThrow(try keychain.store(updatedCredential))
        let updatedValue: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        XCTAssertNotNil(updatedValue)
        XCTAssertEqual(updatedValue?.email, credential.email)
        XCTAssertEqual(updatedValue?.password, updatedCredential.password)
        XCTAssertEqual(updatedValue?.pin, updatedCredential.pin)
        XCTAssertEqual(updatedValue?.dob, updatedCredential.dob)
    }

    func testRetrieveAccounts() {
        let existingAccounts = try! keychain.retrieveAccounts()
        XCTAssertEqual(existingAccounts, [])
        try! keychain.store(credential)
        try! keychain.store(credentialTwo)
        let retrievedAccounts = try! keychain.retrieveAccounts()
        XCTAssertEqual(retrievedAccounts, [Email.test, Email.newUser])
    }

    func testRetrieveAccountsError() {
        let mockManager = MockSecurityItemManager()
        let keychain = Keychain(securityItemManager: mockManager)
        try! keychain.store(credential)
        mockManager.copyMatchingError = .missingEntitlement
        XCTAssertThrowsError(try keychain.retrieveAccounts())
    }

    func testMultipleAccounts() {
        XCTAssertNoThrow(try keychain.store(credential))
        XCTAssertNoThrow(try keychain.store(credentialTwo))
        let retrievedOne: Credential? = try! keychain.retrieveValue(forAccount: Email.test)
        let retrievedTwo: Credential? = try! keychain.retrieveValue(forAccount: Email.newUser)
        XCTAssertNotNil(retrievedOne)
        XCTAssertNotNil(retrievedTwo)
    }

    func testDeleteUnsavedValue() {
        XCTAssertThrowsError(try keychain.delete(credential))
    }

    func testClearAll() {
        try! keychain.store(credential)
        try! keychain.store(credentialTwo)
        try! keychain.store(account)
        let retrievedAccounts = try! keychain.retrieveAccounts()
        XCTAssertEqual(retrievedAccounts, [Email.test, Email.newUser, "test"])
        try! keychain.clearAll()
        XCTAssertEqual(try! keychain.retrieveAccounts(), [])
    }

    func testDeleteWithQeuryError() {
        let query = keychain.query(forAccount: Email.test, service: Keychain.defaultService, accessGroup: accessGroup)
            as! [String: String]
        let mockManager = MockSecurityItemManager()
        let mockKeychain = Keychain(securityItemManager: mockManager)
        mockManager.deleteError = .missingEntitlement
        XCTAssertThrowsError(try mockKeychain.delete(withQuery: query))
    }

    func testStoreQuery() {
        let query = keychain.query(forAccount: Email.test, service: Keychain.defaultService, accessGroup: accessGroup)
            as! [String: String]
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

    func testDataWithAttributes() {
        let mockManager = MockSecurityItemManager()
        mockManager.copyMatchingError = .missingEntitlement
        let keychain = Keychain(securityItemManager: mockManager)
        XCTAssertThrowsError(try keychain.data(forAccount: Email.test, service: Keychain.defaultService, accessGroup: nil))
    }
    
}
