//
//  LoginService.swift
//  Swift_MVVM_Boilerplate
//
//  Created by SGVVN on 27/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class LoginService: NSObject {
    func login(requestModel: LoginRequestModel, completion: @escaping (LoginResponseModel) -> Void) {
        let params = requestModel.getParams()

        NetworkManager().request(Constants.URLs.loginEndPoint, type: .post, params: params, loadingMessage: "Logging...") { (response) in
            //parsing the response
            if let err = response as? Error {
                let model = LoginResponseModel.init(success: false, errorMessage: err.localizedDescription, successMessage: nil, data: nil)
                completion(model)
            } else if let dict = response as? [String: Any] {
                let message = dict["message"] ?? "Login successful"
                let object = dict["data"] ?? [String: Any]()
                let model = LoginResponseModel.init(success: true, errorMessage: nil, successMessage: message as? String, data: object)
                completion(model)
            }
        }
    }
}
