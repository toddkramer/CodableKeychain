
public enum KeychainError: Int, Error {

    case allocate = -108
    case authenticationFailed = -25293
    case bufferTooSmall = -25301
    case createChainFailed = -25318
    case dataNotAvailable = -25316
    case dataNotModifiable = -25317
    case dataTooLarge = -25302
    case decode = -26275
    case duplicateCallback = -25297
    case duplicateItem = -25299
    case duplicateKeychain = -25296
    case inDarkWake = -25320
    case interactionNotAllowed = -25308
    case interactionRequired = -25315
    case invalidCallback = -25298
    case invalidKeychain = -25295
    case invalidItemReference = -25304
    case invalidParameters = -50
    case invalidPreferenceDomain = -25319
    case invalidSearchReference = -25305
    case itemNotFound = -25300
    case keySizeNotAllowed = -25311
    case missingEntitlement = -34018
    case noCertificateModule = -25313
    case noDefaultKeychain = -25307
    case noPolicyModule = -25314
    case noStorageModule = -25312
    case noSuchAttribute = -25303
    case noSuchClass = -25306
    case noSuchKeychain = -25294
    case notAvailable = -25291
    case readOnly = -25292
    case readOnlyAttribute = -25309
    case unimplemented = -4
    case wrongVersion = -25310
    case unknown = -1

    public var localizedDescription: String {
        switch self {
        case .allocate:
            return "Failed to allocate memory."
        case .authenticationFailed:
            return "Authorization and/or authentication failed."
        case .bufferTooSmall:
            return "The buffer is too small."
        case .createChainFailed:
            return "The attempt to create a certificate chain failed."
        case .dataNotAvailable:
            return "The data is not available."
        case .dataNotModifiable:
            return "The data is not modifiable."
        case .dataTooLarge:
            return "The data is too large for the particular data type."
        case .decode:
            return "Unable to decode the provided data."
        case .duplicateCallback:
            return "More than one callback of the same name exists."
        case .duplicateItem:
            return "The item already exists."
        case .duplicateKeychain:
            return "A keychain with the same name already exists."
        case .inDarkWake:
            return "The user interface cannot be displayed because the system is in a dark wake state."
        case .interactionNotAllowed:
            return "Interaction with the Security Server is not allowed."
        case .interactionRequired:
            return "User interaction is required."
        case .invalidCallback:
            return "The callback is not valid."
        case .invalidItemReference:
            return "The item reference is invalid."
        case .invalidKeychain:
            return "The keychain is not valid."
        case .invalidParameters:
            return "One or more parameters passed to the function are not valid."
        case .invalidPreferenceDomain:
            return "The preference domain specified is invalid."
        case .invalidSearchReference:
            return "The search reference is invalid."
        case .itemNotFound:
            return "The item cannot be found."
        case .keySizeNotAllowed:
            return "The key size is not allowed."
        case .missingEntitlement:
            return "Keychain entitlement has not been added."
        case .noCertificateModule:
            return "There is no certificate module available."
        case .noDefaultKeychain:
            return "A default keychain does not exist."
        case .noPolicyModule:
            return "There is no policy module available."
        case .noStorageModule:
            return "There is no storage module available."
        case .noSuchAttribute:
            return "The attribute does not exist."
        case .noSuchClass:
            return "The keychain item class does not exist."
        case .noSuchKeychain:
            return "The keychain does not exist."
        case .notAvailable:
            return "No trust results are available."
        case .readOnly:
            return "Read only error."
        case .readOnlyAttribute:
            return "The attribute is read only."
        case .unimplemented:
            return "A function or operation is not implemented."
        case .wrongVersion:
            return "The version is incorrect."
        case .unknown:
            return "An unknown error occurred."
        }
    }

}
