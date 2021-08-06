//
//  MockBreedsService.swift
//  TheDogSDKTests
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

class MockBreedsService: BreedsServiceProvider {

    var mockSuccess = true
    var emptyResults = false

    func getAllBreeds(page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        if mockSuccess {
            let breeds = BreedsJson.breedsJson.data?.map(to: [Breed].self)
            let paginatedData = PaginatedData(data: breeds)
            completion(paginatedData, nil)
        } else {
            completion(nil, DogServiceError.genericError())
        }
    }

    func searchBreeds(breedName: String, page: Int?, limit: Int?, completion: @escaping ((PaginatedData<[Breed]>?, DogServiceError?) -> Void)) {
        if mockSuccess {
            let json = emptyResults ? BreedsJson.breedsEmptyResultsJson : BreedsJson.breedsSearchJson
            let breeds = json.data?.map(to: [Breed].self)
            let paginatedData = PaginatedData(data: breeds)
            completion(paginatedData, nil)
        } else {
            completion(nil, DogServiceError.genericError())
        }
    }
}
