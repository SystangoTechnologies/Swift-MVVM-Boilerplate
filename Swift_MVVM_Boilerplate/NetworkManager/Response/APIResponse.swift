//
//  APIResponse.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

struct APIResponse {
    var body: [String: Any]?
    var header: [String: Any]?
    var statusCode: Int?
    var errorMessage: String?
}
