//
//  ForgotPasswordViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

struct ForgotPasswordViewModel {
    let usernameEmptyMessage = "Please Enter Username"
    let usernameErrorMessage = "Entered Username is invalid"

    func validateInput(_ username: String?, completion: (Bool, String?) -> Void) {
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
        completion(true, nil)
    }

    func getOtp(_ request: ForgotPasswordRequestModel, completion: @escaping (ForgotPasswordResponseModel) -> Void) {
        print(request.getParams())
        var responseModel = ForgotPasswordResponseModel()
        responseModel.success = true
        responseModel.successMessage = "One Time Password has been set to your registered email"
        completion(responseModel)
    }
}

struct ForgotPasswordRequestModel {
    var username: String
    init(username: String) {
        self.username = username
    }
    func getParams() -> [String: Any] {
        return ["username": username]
    }
}

struct ForgotPasswordResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}
