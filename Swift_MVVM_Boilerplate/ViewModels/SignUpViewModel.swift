//
//  SignUpViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

typealias ValidationCompletion = (Bool, String?) -> Void

struct SignUpViewModel {
    let fullNameLengthRange = (6, 24) // (minimum length, maximum length)
    let fullNameLengthMessage = "Full name length must be in range 6-24 characters."
    let fullNameEmptyMessage = "Please Enter full name"
    let usernameEmptyMessage = "Please Enter Username"
    let usernameErrorMessage = "Entered Username is invalid"
    let passwordEmptyMessage = "Please Enter Password"
    let confirmPasswordEmptyMessage = "Please Enter Confirm Password"
    let passwordLengthRange = (6, 14) // (minimum length, maximum length)
    let passwordErrorMessage = "Password length must be in range 6-14 characters."
    let passwordMismatchErrorMessage = "Not matching password and confirm password"

    func validateInput(_ signupModel: SignUpModel, completion: ValidationCompletion) {

        guard self.validateFullName(signupModel, completion: completion) else { return }

        guard self.validateUsername(signupModel, completion: completion) else { return }

        // Validated successfully.
        completion(true, nil)
    }

    private func validatePasswordAndConfirmPassword(_ signupModel: SignUpModel, completion: ValidationCompletion) -> Bool {
        guard let password = signupModel.password else {
            completion(false, passwordEmptyMessage)
            return false
        }
        if password.isEmpty {
            completion(false, passwordEmptyMessage)
            return false
        } else if !validateTextLength(password, range: passwordLengthRange) {
            completion(false, passwordErrorMessage)
            return false
        }

        if let confirmPassword = signupModel.confirmPassword {
            if confirmPassword.isEmpty {
                completion(false, confirmPasswordEmptyMessage)
                return false
            } else if !validateTextLength(confirmPassword, range: passwordLengthRange) {
                completion(false, passwordErrorMessage)
                return false
            } else if password != confirmPassword {
                completion(false, passwordMismatchErrorMessage)
            }
        } else {
            completion(false, confirmPasswordEmptyMessage)
            return false
        }
        return true
    }

    private func validateUsername(_ signupModel: SignUpModel, completion: ValidationCompletion) -> Bool {
        if let username = signupModel.username {
            if username.isEmpty {
                completion(false, usernameEmptyMessage)
                return false
            } else if !username.isValidEmail() {
                completion(false, usernameErrorMessage)
                return false
            }
        } else {
            completion(false, usernameEmptyMessage)
            return false
        }
        return true
    }

    private func validateFullName(_ signupModel: SignUpModel, completion: ValidationCompletion) -> Bool {
        if let fname = signupModel.fullName {
            if fname.isEmpty {
                completion(false, fullNameEmptyMessage)
                return false
            } else if !self.validateTextLength(fname, range: (6, 24)) {
                completion(false, fullNameLengthMessage)
                return false
            }
        } else {
            completion(false, fullNameEmptyMessage)
            return false
        }
        return true
    }

    private func validateTextLength(_ text: String, range: (Int, Int)) -> Bool {
        return (text.count >= range.0) && (text.count <= range.1)
    }

    func signUp(_ request: SignUpRequestModel, completion: @escaping (SignUpResponseModel) -> Void) {
        let params = request.getParams()

        let apiManager = APIManager()
        apiManager.signUp(params) { (result) in
            print(result)
        }
        print("Signup Input:\(params)")
        var responseModel = SignUpResponseModel()
        responseModel.success = true
        responseModel.successMessage = "User signed up in successfully"
        responseModel.data = ["Success"]
        completion(responseModel)
    }
}

struct SignUpRequestModel {
    var fullName: String
    var username: String
    var password: String
    var confirmPassword: String
    init(_ fullName: String, username: String, password: String, confirmPassword: String) {
        self.fullName = fullName
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }

    func getParams() -> [String: Any] {
        return ["fullName": fullName, "username": username, "password": password, "confirmPassword": confirmPassword]
    }
}

struct SignUpResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}

struct SignUpModel {
    var fullName: String?
    var username: String?
    var password: String?
    var confirmPassword: String?
}
