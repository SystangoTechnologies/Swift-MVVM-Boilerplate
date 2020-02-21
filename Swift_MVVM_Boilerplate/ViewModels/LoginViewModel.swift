//
//  LoginViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

struct LoginViewModel {
    let passwordLengthRange = (6, 14) // (minimum length, maximum length)
    let usernameEmptyMessage = "Please Enter Username"
    let passwordEmptyMessage = "Please Enter Password"
    let usernameErrorMessage = "Entered Username is invalid"
    let passwordErrorMessage = "Password length must be in range 6-10 characters."
    func validateInput(_ username: String?, password: String?, completion: (Bool, String?) -> Void) {
        if let username = username {
            if username.isEmpty {
                completion(false, usernameEmptyMessage)
                return
            } else if !username.isValidEmail() {
                completion(false, usernameErrorMessage)
                return
            }
        } else {
            completion(false, usernameEmptyMessage)
            return
        }
        if let password = password {
            if password.isEmpty {
                completion(false, passwordEmptyMessage)
                return
            } else if !validateTextLength(password, range: passwordLengthRange) {
                completion(false, passwordErrorMessage)
                return
            }
        } else {
            completion(false, passwordEmptyMessage)
            return
        }
        // Validated successfully.
        completion(true, nil)
    }

    private func validateTextLength(_ text: String, range: (Int, Int)) -> Bool {
        return (text.count >= range.0) && (text.count <= range.1)
    }

    func login(_ requestModel: LoginRequestModel, completion: @escaping (LoginResponseModel) -> Void) {
        let params = requestModel.getParams()
        print("Input:\(params)")
        var responseModel = LoginResponseModel()
        responseModel.success = true
        responseModel.successMessage = "User logged in successfully"
        completion(responseModel)

        APIManager().login(params) { (results) in
            print(results)
        }

    }
}

struct LoginRequestModel {
    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    func getParams() -> [String: Any] {
        return ["username": username, "password": password]
    }
}

struct LoginResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}
