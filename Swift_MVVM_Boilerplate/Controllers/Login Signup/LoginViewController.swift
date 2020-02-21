//
//  LoginViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 19/11/19.
//  Copyright © 2019 Systango. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn

class LoginViewController: UIViewController {
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var appleSignView: UIView!
    @IBOutlet weak var facebookSignInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

    fileprivate func configureView() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.configure(5.0, borderColor: UIColor.buttonBorderColor())
        configureAppleSignInBtn()
    }

    fileprivate func configureAppleSignInBtn() {
        let appleSignInBtn = ASAuthorizationAppleIDButton()
        appleSignInBtn.addTarget(self, action: #selector(appleIdButtonTapped), for: .touchUpInside)
        appleSignInBtn.frame = CGRect.init(x: 0, y: 0, width: appleSignView.frame.size.width, height: appleSignView.frame.size.height)
        appleSignView.addSubview(appleSignInBtn)
    }

    @IBAction func loginAction(_ sender: UIButton) {
        self.view.endEditing(true)
        viewModel.validateInput(emailTextField.text, password: passwordTextField.text) { [weak self] (success, message) in
            if success {
                self?.performAPICall()
            } else {
                self?.showAlert("Error!", message: message!, actions: ["Ok"]) { (actionTitle) in
                    print(actionTitle)
                }
            }
        }
    }

    @IBAction func googleSignInAction(_ sender: UIButton) {
        SocialManager.shared.loginWithSocialType(socialType: .google, delegate: self)
    }

    @IBAction func facebookSignInAction(_ sender: Any) {
        SocialManager.shared.loginWithSocialType(socialType: .faceBook, delegate: self)
    }

    @objc func appleIdButtonTapped() {
        //        let request = ASAuthorizationAppleIDProvider().createRequest()
        //        request.requestedScopes = [.fullName, .email]
        //
        //        let controller = ASAuthorizationController(authorizationRequests: [request])
        //        controller.delegate = self
        //        controller.presentationContextProvider = self
        //        controller.performRequests()
        SocialManager.shared.loginWithSocialType(socialType: SocialLoginType.apple, delegate: self)
    }

    private func performAPICall() {
        let request = LoginRequestModel(username: emailTextField.text!, password: passwordTextField.text!)
        viewModel.login(request) { (responseModel) in
            if responseModel.success {
                RedirectionHelper.redirectToDashboard()
            }
        }
    }
}

extension LoginViewController: SocialManagerDelegate {
    func didLoginSuccessFully(socialType: SocialLoginType) {
        RedirectionHelper.redirectToDashboard()
    }

    func showGoogleSignInPresentingViewController() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

//extension LoginViewController: ASAuthorizationControllerDelegate {
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            let appleId = appleIDCredential.user
//
//            let appleUserFirstName = appleIDCredential.fullName?.givenName
//
//            let appleUserLastName = appleIDCredential.fullName?.familyName
//
//            let appleUserEmail = appleIDCredential.email
//
//            //Write your code
//        }
//        else if let passwordCredential = authorization.credential as? ASPasswordCredential {
//            let appleUsername = passwordCredential.user
//
//            let applePassword = passwordCredential.password
//
//            //Write your code
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print("\(error.localizedDescription)")
//    }
//}

//extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!
//    }
//}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            self.loginAction(loginButton)
        }
        return true
    }
}
