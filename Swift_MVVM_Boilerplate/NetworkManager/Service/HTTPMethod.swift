//
//  HTTPType.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

struct ErrorMessage {
    static let kInvalidURL = "Invalid URL"
    static let kInvalidHeaderValue = "Header value is not string"
    static let kNoData = "No Data available"
    static let kConversionFailed = "Conversion Failed"
    static let kInvalidJSON = "Invalid JSON"
    static let kInvalidResponse = "Invalid Response"
    static let kAuthenticationError = "You need to be authenticated first."
    static let kBadRequest = "Bad request"
    static let kOutdatedRequest = "The url you requested is outdated."
    static let kRequestFailed = "Network request failed."
}
