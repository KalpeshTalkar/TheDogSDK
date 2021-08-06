//
//  BreedImage.swift
//  TheDogSDK
//
//  Created by Kalpesh on 20/04/21.
//

import Foundation

public struct BreedImage: Decodable {
    public let id: String
    public let url: String?
    public let height: Int
    public let width: Int
    public let breeds: Array<Breed>?
}
