//
//  ResetPasswordViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    var viewModel = ResetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    private func configureView() {
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        resetPasswordButton.configure(5.0, borderColor: UIColor.buttonBorderColor())
    }

    @IBAction func resetPasswordAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { (success, errorMessage) in
            if success {
                self.performAPICall()
            } else {
                self.showAlert("Error!", message: errorMessage!, actions: ["Ok"]) { (title) in
                    print("Action title: \(title)")
                }
            }
        }
    }

    private func performAPICall() {
        let requestModel = ResetPasswordRequestModel(passwordTextField.text!, confirmPassword: confirmPasswordTextField.text!)
        viewModel.resetPassword(requestModel) { (responseModel) in
            if responseModel.success {
                self.showAlert("Success", message: responseModel.successMessage!, actions: ["Done"]) { _ in
                    print(responseModel.successMessage!)
                    DispatchQueue.main.async {
                        RedirectionHelper.redirectToLogin()
                    }
                }
            } else {
                print(responseModel.errorMessage ?? "No error message")
            }
        }
    }
}

extension ResetPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            resetPasswordAction(resetPasswordButton)
        }
        return true
    }
}
