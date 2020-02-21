//
//  VerifyOTPViewModel.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import Foundation

struct VerifyOTPViewModel {
    func submitOTP(_ request: VerifyOTPRequestModel, completion: @escaping (VerifyOTPResponseModel) -> Void) {
        print(request.getParams())
        var responseModel = VerifyOTPResponseModel()
        responseModel.success = true
        responseModel.successMessage = "OTP Verified successfully"
        completion(responseModel)
    }
}

struct VerifyOTPRequestModel {
    var otpText = ""
    init(otpText: String) {
        self.otpText = otpText
    }
    func getParams() -> [String: Any] {
        return ["otp": otpText]
    }
}

struct VerifyOTPResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}
