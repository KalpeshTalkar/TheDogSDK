//
//  Breed.swift
//  TheDogSDK
//
//  Created by Kalpesh on 20/04/21.
//

import Foundation

public struct Breed: Decodable {
    public let id: Int
    public let name: String
    public let description: String?
    public let history: String?
    public let lifeSpan: String?
    public let temperament: String?
    public let origin: String?
    public let breedGroup: String?
    public let bredFor: String?
    public let referenceImageId: String?
    public let image: BreedImage?
    public let height: BreedMeasurement?
    public let weight: BreedMeasurement?
}
