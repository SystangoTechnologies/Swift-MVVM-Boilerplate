//
//  EndPointType.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var module: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
}
