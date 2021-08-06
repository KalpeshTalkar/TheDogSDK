//
//  DogSDK.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

public class DogSDK {

    /// Access the singleton instance  to configure the SDK.
    public static let instance = DogSDK()

    /// API Key required to access the services.
    public var apiKey: String = ""

    private init() {}

    private var bundle: Bundle? {
        return Bundle(identifier: bundleIdentifier)
    }

    /// TheDogSDK version.
    public var bundleIdentifier: String {
        return "kalpesh.TheDogSDK"
    }

    /// TheDogSDK bundle info dictionary.
    public var infoDictionary: [String : Any]? {
        return bundle?.infoDictionary
    }

    /// TheDogSDK build number.
    public var build: String? {
        return infoDictionary?[kCFBundleVersionKey as String] as? String
    }

    /// TheDogSDK version.
    public var version: String? {
        return infoDictionary?[kCFBundleInfoDictionaryVersionKey as String] as? String
    }
}
