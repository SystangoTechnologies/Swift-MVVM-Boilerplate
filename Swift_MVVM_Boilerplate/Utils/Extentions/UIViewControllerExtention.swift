//
//  UIViewControllerExtention.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, message: String, actions: [String], completion: @escaping ((String) -> Void)) {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for title in actions {
            controller.addAction(UIAlertAction.init(title: title, style: .default, handler: { _ in
                completion(title)
            }))
        }
        self.present(controller, animated: true, completion: nil)
    }
}
