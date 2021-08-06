//
//  DogSDKService.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

public class DogSDKService {
    
    private let imagesService: ImagesServiceProvider
    private let breedsSerivce: BreedsServiceProvider
    
    init(imagesService: ImagesServiceProvider = ImagesService(),
         breedsSerivce: BreedsServiceProvider = BreedsService()) {
        self.imagesService = imagesService
        self.breedsSerivce = breedsSerivce
    }
    
    public static let `default` = DogSDKService()

    /// Searches all approved images.
    /// - Parameters:
    ///   - params: Image search params.
    ///   - completion: Result block.
    public func searchImages(params: BreedImageParams, completion: @escaping ((PaginatedData<[BreedImage]>?, DogServiceError?) -> Void)) {
        let mimeTypes = params.mimeTypes?.map({ $0.rawValue }).joined(separator: ",")
        imagesService.searchImages(breed: params.breed, size: params.size.rawValue, hasBreeds: params.hasBreeds, order: params.order.rawValue, page: params.page, limit: params.limit, mimeTypes: mimeTypes, completion: completion)
    }
    
    /// Get all breeds.
    /// - Parameters:
    ///   - page: Page index.
    ///   - limit: Results per page. Defaut is 10, min is 1 and max is 100.
    ///   - completion: Result block.
    public func getAllBreeds(page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        breedsSerivce.getAllBreeds(page: page, limit: limit, completion: completion)
    }

    /// Searchbreeds by name.
    /// - Parameters:
    ///   - breedName: Name of the breed.
    ///   - page: Page index.
    ///   - limit: Results per page. Defaut is 10, min is 1 and max is 100.
    ///   - completion: Result block.
    public func searchBreeds(breedName: String, page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        breedsSerivce.searchBreeds(breedName: breedName, page: page, limit: limit, completion: completion)
    }
    
}



