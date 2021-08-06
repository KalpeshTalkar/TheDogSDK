//
//  BreedsService.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

protocol BreedsServiceProvider {

    /// Get all breeds.
    /// - Parameters:
    ///   - page: (Optional) Page index.
    ///   - limit: (Optional) Results per page. Defaut is 10, min is 1 and max is 100.
    ///   - completion: Result block.
    func getAllBreeds(page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void))

    /// Search breeds by name.
    /// - Parameters:
    ///   - breedName: Name of the breed.
    ///   - page: (Optional) Page index.
    ///   - limit: (Optional) Results per page. Defaut is 10, min is 1 and max is 100.
    ///   - completion: Result block.
    func searchBreeds(breedName: String, page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void))
}

class BreedsService: APIService, BreedsServiceProvider {

    private struct Endpoints {
        static let breeds = "breeds"
        static let search = "breeds/search"
    }

    func getAllBreeds(page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        var params = [String : Any]()
        if let page = page {
            params["page"] = page
        }
        if let limit = limit {
            params["limit"] = limit
        }
        executeRequest(endPoint: Endpoints.breeds, method: .get, queryParams: params) { (data, response, error) in
            let breeds = data?.map(to: [Breed].self, keyDecodingStrategy: .convertFromSnakeCase)
            var paginationData: PaginatedData<[Breed]>?
            if let headers = response?.allHeaderFields {
                paginationData = PaginatedData<[Breed]>(dictionary: headers, data: breeds)
            }
            completion(paginationData, error)
        }
    }

    func searchBreeds(breedName: String, page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        var params = [String : Any]()
        params["q"] = breedName
        if let page = page {
            params["page"] = page
        }
        if let limit = limit {
            params["limit"] = limit
        }
        executeRequest(endPoint: Endpoints.search, method: .get, queryParams: params) { (data, response, error) in
            let breeds = data?.map(to: [Breed].self, keyDecodingStrategy: .convertFromSnakeCase)
            var paginationData: PaginatedData<[Breed]>?
            if let headers = response?.allHeaderFields {
                paginationData = PaginatedData<[Breed]>(dictionary: headers, data: breeds)
            }
            completion(paginationData, error)
        }
    }
}
