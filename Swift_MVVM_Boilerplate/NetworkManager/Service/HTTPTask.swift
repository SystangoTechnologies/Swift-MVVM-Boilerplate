//
//  HTTPTask.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(parameters: [String: Any]?)
    case requestParametersAndHeaders(bodyParameters: [String: Any]?, additionHeaders: [String: String]?)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResponse) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResponse) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
