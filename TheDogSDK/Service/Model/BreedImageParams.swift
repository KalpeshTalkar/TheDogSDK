//
//  BreedImageParams.swift
//  TheDogSDK
//
//  Created by Kalpesh on 21/04/21.
//

import Foundation

public enum SortOrder: String {
    case random = "RANDOM"
    case ascending = "ASC"
    case descending = "DESC"
}

public enum BreedImageSize: String {
    case thumbnail = "thumb"
    case small
    case medium = "med"
    case full
}

public enum MimeType: String {
    case jpg
    case png
    case gif
}

public struct BreedImageParams {
    public var breed: String? = nil
    public var size: BreedImageSize = .medium
    public var hasBreeds: Bool? = nil
    public var order: SortOrder = .random
    public var page: Int? = nil
    public var limit: Int? = nil
    public var mimeTypes:Array<MimeType>?

    public init(page: Int? = nil, limit: Int? = nil) {
        self.page = page
        self.limit = limit
    }
}
