
import XCTest
@testable import CodableKeychain

class KeychainErrorTests: XCTestCase {

    struct Test {
        let input: OSStatus
        let output: KeychainError
    }

    var tests: [Test] {
        return [
            Test(input: errSecAllocate, output: .allocate),
            Test(input: errSecAuthFailed, output: .authenticationFailed),
            Test(input: errSecBufferTooSmall, output: .bufferTooSmall),
            Test(input: errSecCreateChainFailed, output: .createChainFailed),
            Test(input: errSecDataNotAvailable, output: .dataNotAvailable),
            Test(input: errSecDataNotModifiable, output: .dataNotModifiable),
            Test(input: errSecDataTooLarge, output: .dataTooLarge),
            Test(input: errSecDecode, output: .decode),
            Test(input: errSecDuplicateCallback, output: .duplicateCallback),
            Test(input: errSecDuplicateItem, output: .duplicateItem),
            Test(input: errSecDuplicateKeychain, output: .duplicateKeychain),
            Test(input: errSecInDarkWake, output: .inDarkWake),
            Test(input: errSecInteractionNotAllowed, output: .interactionNotAllowed),
            Test(input: errSecInteractionRequired, output: .interactionRequired),
            Test(input: errSecInvalidCallback, output: .invalidCallback),
            Test(input: errSecInvalidItemRef, output: .invalidItemReference),
            Test(input: errSecInvalidKeychain, output: .invalidKeychain),
            Test(input: errSecParam, output: .invalidParameters),
            Test(input: errSecInvalidPrefsDomain, output: .invalidPreferenceDomain),
            Test(input: errSecInvalidSearchRef, output: .invalidSearchReference),
            Test(input: errSecItemNotFound, output: .itemNotFound),
            Test(input: errSecKeySizeNotAllowed, output: .keySizeNotAllowed),
            Test(input: errSecMissingEntitlement, output: .missingEntitlement),
            Test(input: errSecNoCertificateModule, output: .noCertificateModule),
            Test(input: errSecNoDefaultKeychain, output: .noDefaultKeychain),
            Test(input: errSecNoPolicyModule, output: .noPolicyModule),
            Test(input: errSecNoStorageModule, output: .noStorageModule),
            Test(input: errSecNoSuchAttr, output: .noSuchAttribute),
            Test(input: errSecNoSuchClass, output: .noSuchClass),
            Test(input: errSecNoSuchKeychain, output: .noSuchKeychain),
            Test(input: errSecNotAvailable, output: .notAvailable),
            Test(input: errSecReadOnly, output: .readOnly),
            Test(input: errSecReadOnlyAttr, output: .readOnlyAttribute),
            Test(input: errSecUnimplemented, output: .unimplemented),
            Test(input: errSecWrongSecVersion, output: .wrongVersion),
            Test(input: OSStatus(-1), output: .unknown),
        ]
    }

    func testErrorInitialization() {
        tests.forEach {
            let output = KeychainError(rawValue: Int($0.input))
            XCTAssertEqual(output?.localizedDescription, $0.output.localizedDescription)
        }
    }

}
