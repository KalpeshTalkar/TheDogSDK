//
//  APIService.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

/// Service domain.
fileprivate let domain = "https://api.thedogapi.com"

public enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// The base service of TheDogSDK to perform all the service requests.
/// All other services should inherit this base APIService.
class APIService {

    private let kAPIKey = "x-api-key"
    private let session: URLSession = URLSession.shared

    typealias ServiceCompletion = (_ data: Data?, _ response: HTTPURLResponse?, _ error: DogServiceError?) -> Void

    /// Execute service request.
    /// - Parameters:
    ///   - endPoint: Endpoint of the service.
    ///   - method: HTTPRequestMethod
    ///   - headers: (Optional) Headers required for the service.
    ///   - queryParams: (Optional) Url query parameters.
    ///   - body: (Optional) Request body parameters.
    ///   - completion: Completion block.
    func executeRequest(endPoint: String, method: HTTPRequestMethod, headers: [String : String]? = nil, queryParams: [String : Any]? = nil, body: [String : Any]? = nil, completion: ServiceCompletion? = nil) {

        // The below API key check is commented since the services allow fetching data (with limits) without API key.
        // Business call: To restrict the usage of the services without API key, uncomment the below code.
        /*guard !DogSDK.instance.apiKey.isEmpty else {
            completion?(nil, nil, DogServiceError.apiKeyMissingError())
            return
        }*/

        let path = "\(domain)/v1/\(endPoint)"
        guard let url = URL(string: path) else {
            completion?(nil, nil, DogServiceError.invalidUrlError())
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let headers = headers ?? [:]
        request.setValue(DogSDK.instance.apiKey, forHTTPHeaderField: kAPIKey)
        headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let queryParams = queryParams {
            var queryItems = [URLQueryItem]()
            queryParams.forEach { (key, value) in
                let strValue = (value as? String) ?? "\(value)"
                queryItems.append(URLQueryItem(name: key, value: strValue))
            }

            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queryItems

            request.url = urlComponents?.url
        }

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        session.dataTask(with: request) { (data, response, error) in
            let response = response as? HTTPURLResponse

            var serviceError: DogServiceError? = nil
            if let error = error {
                serviceError = DogServiceError(message: error.localizedDescription, code: response?.statusCode)
            }

            DispatchQueue.main.async {
                completion?(data, response, serviceError)
            }

        }.resume()
    }
}
