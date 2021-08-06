//
//  JSONUtils.swift
//  TheDogSDK
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

extension Data {

    /// Foundation object from given JSON data.
    var jsonValue: Any? {
        return try? JSONSerialization.jsonObject(with: self, options: [.mutableContainers])
    }

    /// Decode an instance of the indicated type.
    /// - Parameters:
    ///   - to: Type of struct or class
    ///   - keyDecodingStrategy: Value that determine how a type's coding keys are decoded from JSON keys.
    ///   - dateDecodingStrategy: Strategy for formatting dates when decoding them from JSON.
    /// - Returns:Decoded instance of the indicated type.
    func map<T: Decodable>(to type: T.Type, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil) -> T? {
        let jsonDecoder = JSONDecoder()
        if let keyDecodingStrategy = keyDecodingStrategy {
            jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
        }
        if let dateDecodingStrategy = dateDecodingStrategy {
            jsonDecoder.dateDecodingStrategy = dateDecodingStrategy
        }
        return try? jsonDecoder.decode(type, from: self)
    }
}

extension Encodable {

    /// Encodes an instance of the indicated type.
    /// - Parameters:
    ///   - keyEncodingStrategy: Value that determine how a type's coding keys are encoded as JSON keys.
    ///   - dateEncodingStrategy: Formatting strategy for formatting dates when encoding a date as JSON.
    /// - Returns:Encoded instance of the indicated type..
    func toData(keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? = nil, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? = nil) ->Data? {
        let jsonEncoder = JSONEncoder()
        if let keyEncodingStrategy = keyEncodingStrategy {
            jsonEncoder.keyEncodingStrategy = keyEncodingStrategy
        }
        if let dateEncodingStrategy = dateEncodingStrategy {
            jsonEncoder.dateEncodingStrategy = dateEncodingStrategy
        }
        return try? jsonEncoder.encode(self)
    }
}

extension String {
    
    /// Returns a Data containing a representation of the String encoded using a given encoding.
    var data: Data? {
        return data(using: .utf8)
    }
}
