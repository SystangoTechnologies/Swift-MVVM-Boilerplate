//
//  SettingsBundleHelper.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 26/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

enum Environment: String {
    case production
    case testing
    case development
    var baseUrl: String {
        switch self {
        case .development:
            return Constants.URLs.development
        case .testing:
            return Constants.URLs.testing
        default:
            return Constants.URLs.production
        }
    }
}

struct SettingsBundleHelper {
    static let shared = SettingsBundleHelper()
    private init() {}
    var currentEnvironment: Environment {
        if let env = UserDefaults.standard.string(forKey: Constants.Keys.environment) {
            return Environment(rawValue: env.lowercased()) ?? Environment.production
        }
        return Environment.production
    }
}
