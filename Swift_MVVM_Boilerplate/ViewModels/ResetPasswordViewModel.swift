//
//  ResetPasswordViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

struct ResetPasswordViewModel {
    let passwordEmptyMessage = "Please Enter Password"
    let confirmPasswordEmptyMessage = "Please Enter Confirm Password"
    let passwordLengthRange = (6, 14) // (minimum length, maximum length)
    let passwordErrorMessage = "Password length must be in range 6-14 characters."
    let passwordMismatchErrorMessage = "Not matching password and confirm password"

    func validateInput(_ newPassword: String?, confirmPassword: String?, completion: (Bool, String?) -> Void) {
        guard let password = newPassword else {
            completion(false, passwordEmptyMessage)
            return
        }

        if password.isEmpty {
            completion(false, passwordEmptyMessage)
            return
        } else if !validateTextLength(password, range: passwordLengthRange) {
            completion(false, passwordErrorMessage)
            return
        }

        if let confirmPassword = confirmPassword {
            if confirmPassword.isEmpty {
                completion(false, confirmPasswordEmptyMessage)
                return
            } else if !validateTextLength(confirmPassword, range: passwordLengthRange) {
                completion(false, passwordErrorMessage)
                return
            } else if password != confirmPassword {
                completion(false, passwordMismatchErrorMessage)
            }
        } else {
            completion(false, confirmPasswordEmptyMessage)
            return
        }
        // Validated successfully.
        completion(true, nil)
    }

    private func validateTextLength(_ text: String, range: (Int, Int)) -> Bool {
        return (text.count >= range.0) && (text.count <= range.1)
    }

    func resetPassword(_ request: ResetPasswordRequestModel, completion: @escaping (ResetPasswordResponseModel) -> Void) {
        let params = request.getParams()
        print("Reset Password Input:\(params)")
        var responseModel = ResetPasswordResponseModel()
        responseModel.success = true
        responseModel.successMessage = "Password reset successfully"
        responseModel.data = ["Success"]
        completion(responseModel)
    }
}

struct ResetPasswordRequestModel {
    var password: String
    var confirmPassword: String

    init(_ password: String, confirmPassword: String) {
        self.password = password
        self.confirmPassword = confirmPassword
    }

    func getParams() -> [String: Any] {
        return ["password": password, "confirmPassword": confirmPassword]
    }
}

struct ResetPasswordResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}
