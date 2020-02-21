//
//  APIManager.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/02/20.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

public enum ErrorType: Error {
    case noInternet
    case authRequired
    case badRequest
    case outdatedRequest
    case requestFailed
    case invalidResponse
    case noData

    static func errorViewModel(_ errorType: ErrorType) -> ErrorViewModel {
        let genereicErrorViewModel = ErrorViewModel(title: Strings.Error.genericErrorTitle, message: Strings.Error.genericErrorMessage, buttonTitles: [Strings.Error.okButtonTitle])
        switch errorType {
        case .noInternet: return ErrorViewModel(title: Strings.Error.genericErrorTitle, message: Strings.Error.noNetworkMessage, buttonTitles: [Strings.Error.okButtonTitle])
        case .authRequired: return genereicErrorViewModel
        case .badRequest: return genereicErrorViewModel
        case .outdatedRequest: return genereicErrorViewModel
        case .requestFailed: return genereicErrorViewModel
        case .invalidResponse: return genereicErrorViewModel
        case .noData: return ErrorViewModel(title: Strings.Error.genericErrorTitle, message: Strings.Error.noDataMessage, buttonTitles: [Strings.Error.okButtonTitle])
        }
    }
}

enum Result {
    case success(APIResponse)
    case failure(ErrorType)
}

struct APIManager {
    let manager = Manager<UserApi>()
    func login(_ params: [String: Any], completion: @escaping APICompletion) {
        manager.request(.login) { result in
            completion(result)
        }
    }

    func signUp(_ params: [String: Any], completion: @escaping APICompletion) {
        manager.request(.signup) { result in
            completion(result)
        }
    }

}
