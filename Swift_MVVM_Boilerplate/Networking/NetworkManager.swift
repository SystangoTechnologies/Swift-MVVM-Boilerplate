//
//  NetworkManager.swift
//  Swift_MVVM_Boilerplate
//
//  Created by SGVVN on 27/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit
import KRProgressHUD

enum RequestType: String {
    case get
    case post
}

class NetworkManager: NSObject {
    func request(_ endpoint: String, type: RequestType = .get, params: [String: Any]? = [:], loadingMessage: String? = nil, completion: @escaping (Any) -> Void) {
        var url = Constants.URLs.baseUrl + endpoint

        if let dictParams = params, type == .get {
            let queries = dictParams.map { (arg) -> String in
                let (key, value) = arg
                return "\(key)=\(value)"
            }
            let queryParams = queries.joined(separator: "&")
            if !queryParams.isEmpty {
                url += "?\(queryParams)"
            }
        }

        guard let serviceURL = URL.init(string: url) else {
            var response = LoginResponseModel()
            response.errorMessage = Constants.Message.invalidUrl
            completion(response)
            return
        }

        var request = URLRequest(url: serviceURL)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        request.httpMethod = type.rawValue.uppercased()
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        /*
         Put additional header in request
         request.setValue("ACCESS TOKEN STRING FOR AUTHENTICATE REQUEST", forHTTPHeaderField: "access_token")
         */
        // If request type is post, then paramaters must be set in the request
        if let params = params, type == .post {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
                return
            }
            request.httpBody = httpBody
        }

        if let message = loadingMessage {
            KRProgressHUD.show(withMessage: message)
        } else {
            KRProgressHUD.show()
        }

        let task = session.dataTask(with: request) { (data, _, error) in
            KRProgressHUD.dismiss()
            if let error = error {
                completion(error)
                return
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                    completion(json)
                } catch {
                    completion(error)
                }
            }
        }
        // do whatever you need with the task e.g. run
        task.resume()
    }
}
