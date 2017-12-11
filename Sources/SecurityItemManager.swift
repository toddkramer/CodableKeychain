//
//  SecurityItemManager.swift
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

import Foundation
import Security

protocol SecurityItemManaging {

    func add(withAttributes attributes: [String: Any], result: UnsafeMutablePointer<CoreFoundation.CFTypeRef?>?) -> OSStatus
    func update(withQuery query: [String: Any], attributesToUpdate: [String: Any]) -> OSStatus
    func delete(withQuery query: [String: Any]) -> OSStatus
    func copyMatching(_ query: [String: Any], result: UnsafeMutablePointer<CoreFoundation.CFTypeRef?>?) -> OSStatus

}

final class SecurityItemManager {

    static let `default` = SecurityItemManager()

}

extension SecurityItemManager: SecurityItemManaging {

    func add(withAttributes attributes: [String: Any], result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return SecItemAdd(attributes as CFDictionary, result)
    }

    func update(withQuery query: [String: Any], attributesToUpdate: [String: Any]) -> OSStatus {
        return SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
    }

    func delete(withQuery query: [String : Any]) -> OSStatus {
        return SecItemDelete(query as CFDictionary)
    }

    func copyMatching(_ query: [String : Any], result: UnsafeMutablePointer<CFTypeRef?>?) -> OSStatus {
        return SecItemCopyMatching(query as CFDictionary, result)
    }

}
