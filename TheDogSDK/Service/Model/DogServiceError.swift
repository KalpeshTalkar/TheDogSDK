//
//  DogServiceError.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

public struct DogServiceError: LocalizedError {

    let message: String?
    let code: Int?

    public var errorDescription: String? {
        return message
    }

    public var failureReason: String? {
        return message
    }

    static func genericError() -> DogServiceError {
        return DogServiceError(message: "Oops! Something is not right. Please try again later.", code: 900)
    }

    static func apiKeyMissingError() -> DogServiceError {
        return DogServiceError(message: "API key missing. Please provide API key to access the services. Use DogSDK.instance.apiKey = \"YOUR_API_KEY\" to set the API key. Visit https://thedogapi.com/ to get an API key.", code: 901)
    }
    
    static func invalidUrlError() -> DogServiceError {
        return DogServiceError(message: "Invalid URL.", code: 902)
    }
}
