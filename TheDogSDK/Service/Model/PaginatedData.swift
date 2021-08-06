//
//  PaginatedData.swift
//  TheDogSDK
//
//  Created by Kalpesh on 24/04/21.
//

import Foundation

public struct PaginatedData<T> {
    public let count: Int?
    public let limit: Int?
    public let page: Int?
    public let data: T?

    public init(dictionary: [AnyHashable : Any]? = nil, data: T?) {
        let paginationCount = dictionary?["Pagination-Count"]
        if let intValue = paginationCount as? Int {
            count = intValue
        } else if let strValue = paginationCount as? String {
            count = Int(strValue)
        } else {
            count = nil
        }

        let paginationPage = dictionary?["Pagination-Page"]
        if let intValue = paginationPage as? Int {
            page = intValue
        } else if let strValue = paginationPage as? String {
            page = Int(strValue)
        } else {
            page = nil
        }

        let paginationLimit = dictionary?["Pagination-Limit"]
        if let intValue = paginationLimit as? Int {
            limit = intValue
        } else if let strValue = paginationLimit as? String {
            limit = Int(strValue)
        } else {
            limit = nil
        }

        self.data = data
    }
}
