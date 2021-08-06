//
//  ImagesService.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

protocol ImagesServiceProvider {

    /// Searchs all approved breed images.
    /// - Parameters:
    ///   - breed: (Optional )Breed name.
    ///   - size: (Optional) Image size (full, medd, small, thumb)
    ///   - hasBreeds: (Optional) To only get images with breed data.
    ///   - order: (Optional) Sort order. (RANDOM, ASC, DESC). Default is RANDOM.
    ///   - page: (Optional) Page index to paginate through results.
    ///   - limit: (Optional) Number of results to return, up to 25 with a valid API-Key
    ///   - mimeTypes: (Optional) Image mime type. (jpg, png, gif)
    ///   - completion: Result block.
    func searchImages(breed: String?, size: String?, hasBreeds: Bool?, order: String?, page: Int?, limit: Int?, mimeTypes: String?, completion: @escaping ((PaginatedData<[BreedImage]>?, DogServiceError?) -> Void))
}

class ImagesService: APIService, ImagesServiceProvider {

    private struct Endpoints {
        static let imagesSearch = "images/search"
    }

    func searchImages(breed: String?, size: String?, hasBreeds: Bool?, order: String?, page: Int?, limit: Int?, mimeTypes: String?, completion: @escaping ((PaginatedData<[BreedImage]>?, DogServiceError?) -> Void)) {
        var params = [String : Any]()
        if let page = page {
            params["page"] = page
        }
        if let limit = limit {
            params["limit"] = limit
        }
        if let breed = breed, !breed.isEmpty {
            params["breed"] = breed
        }
        if let size = size, !size.isEmpty {
            params["size"] = size
        }
        if let hasBreeds = hasBreeds {
            params["has_breed"] = hasBreeds
        }
        if let order = order, !order.isEmpty {
            params["order"] = order
        }
        if let mimeTypes = mimeTypes, !mimeTypes.isEmpty {
            params["mime_types"] = mimeTypes
        }
        executeRequest(endPoint: Endpoints.imagesSearch, method: .get, queryParams: params) { (data, response, error) in
            let images = data?.map(to: [BreedImage].self, keyDecodingStrategy: .convertFromSnakeCase)
            var paginationData: PaginatedData<[BreedImage]>?
            if let headers = response?.allHeaderFields {
                paginationData = PaginatedData<[BreedImage]>(dictionary: headers, data: images)
            }
            completion(paginationData, error)
        }
    }
}
