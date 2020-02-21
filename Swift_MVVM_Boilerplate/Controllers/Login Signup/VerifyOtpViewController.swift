//
//  VerifyOtpViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 20/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit

class VerifyOtpViewController: UIViewController {

    @IBOutlet weak var otp1TextField: UITextField!
    @IBOutlet weak var otp2TextField: UITextField!
    @IBOutlet weak var otp3TextField: UITextField!
    @IBOutlet weak var otp4TextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    var arrOtpFields = [UITextField]()
    var viewModel = VerifyOTPViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        arrOtpFields = [otp1TextField, otp2TextField, otp3TextField, otp4TextField]
        // Do any additional setup after loading the view.
    }

    private func configureView() {
        otp1TextField.delegate = self
        otp2TextField.delegate = self
        otp3TextField.delegate = self
        otp4TextField.delegate = self
        submitButton.configure(5.0, borderColor: UIColor.buttonBorderColor())

        otp1TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        otp2TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        otp3TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        otp4TextField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
    }

    @IBAction func submitAction(_ sender: UIButton) {
        self.view.endEditing(true)
        let otpText = arrOtpFields.map {$0.text!}.joined()
        if otpText.count != 4 { return }
        self.performAPICall(otpText)
    }

    private func performAPICall(_ otpText: String) {
        let requestModel = VerifyOTPRequestModel(otpText: otpText)
        viewModel.submitOTP(requestModel) { _ in
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constants.Segue.resetPassword, sender: nil)
            }
        }
    }
}

extension VerifyOtpViewController {
    @objc func textFieldDidChange(textField: UITextField) {
        let text = textField.text
        if  text?.count == 1 {
            switch textField {
            case otp1TextField:
                otp2TextField.becomeFirstResponder()
            case otp2TextField:
                otp3TextField.becomeFirstResponder()
            case otp3TextField:
                otp4TextField.becomeFirstResponder()
            case otp4TextField:
                otp4TextField.resignFirstResponder()
                self.submitAction(submitButton)
            default:
                break
            }
        }
        if text?.isEmpty ?? false {
            switch textField {
            case otp1TextField:
                otp1TextField.becomeFirstResponder()
            case otp2TextField:
                otp1TextField.becomeFirstResponder()
            case otp3TextField:
                otp2TextField.becomeFirstResponder()
            case otp4TextField:
                otp3TextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
}

extension VerifyOtpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.count > 1 ? false: true
    }
}
