//
//  MockImagesService.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

class MockImagesService: ImagesServiceProvider {

    var mockSuccess = true

    func searchImages(breed: String?, size: String?, hasBreeds: Bool?, order: String?, page: Int?, limit: Int?, mimeTypes: String?, completion: @escaping ((PaginatedData<[BreedImage]>?, DogServiceError?) -> Void)) {
        if mockSuccess {
            let images = ImagesJson.imagesSearchJson.data?.map(to: [BreedImage].self)
            let paginatedData = PaginatedData(data: images)
            completion(paginatedData, nil)
        } else {
            completion(nil, DogServiceError.genericError())
        }
    }

}
