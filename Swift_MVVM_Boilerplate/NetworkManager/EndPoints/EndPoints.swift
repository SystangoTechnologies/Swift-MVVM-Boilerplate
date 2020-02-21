//
//  EndPoints.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

protocol BaseURL {
    static var baseURL: String { get }
}

enum APIBuilder {
    struct APIBuilderConstants {
        static let ApiScheme = "https"
        static let ApiHost = "domain-name.com"
    }
}

extension APIBuilder: BaseURL {
    static var baseURL: String {
        return "\(APIBuilder.APIBuilderConstants.ApiScheme)://\(APIBuilder.APIBuilderConstants.ApiHost)"
    }
}

public enum UserApi {
    case login
    case signup
}

extension UserApi: EndPointType {
    var module: String {
        return "/restApi"
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .signup:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {
        case .login:
            return .request
        case .signup:
            return .request
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
