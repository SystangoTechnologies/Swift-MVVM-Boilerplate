//
//  ForgotPasswordViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var getOtpButton: UIButton!

    var viewModel = ForgotPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

    private func configureView() {
        emailTextField.delegate = self
        getOtpButton.configure(5.0, borderColor: UIColor.buttonBorderColor())
    }

    @IBAction func getOTPAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(emailTextField.text) { (success, errorMessage) in
            if success {
                self.performAPICall()
            } else {
                self.showAlert("Opps!", message: errorMessage!, actions: ["Ok"]) { _ in
                }
            }
        }
    }

    private func performAPICall() {
        let requestModel = ForgotPasswordRequestModel(username: emailTextField.text!)
        viewModel.getOtp(requestModel) { _ in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.verifyOTP, sender: nil)
            }
        }
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            getOTPAction(getOtpButton)
        }
        return true
    }

}
