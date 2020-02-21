//
//  SocialManager.swift
//  Swift_MVVM_Boilerplate
//
//  Created by MacMini34 on 29/01/20.
//  Copyright © 2020 Systango. All rights reserved.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit

protocol SocialManagerDelegate: class {
    func didLoginSuccessFully(socialType: SocialLoginType)
    func showGoogleSignInPresentingViewController()
}

class SocialManager: NSObject {
    static let shared = SocialManager()

    weak var delegateSocialManager: SocialManagerDelegate?

    func login() {
        print("login")
    }

    func loginWithSocialType(socialType: SocialLoginType, delegate: SocialManagerDelegate) {
        switch socialType {
        case .google:
            loginWithGoogleWithDelegate(delegate: delegate)
        case .faceBook:
            loginWithFacebookWithDelegate(delegate: delegate)
        case .apple:
            loginWithAppleWithDelegate(delegate: delegate)
        }
        print("\(socialType)")
    }

    fileprivate func loginWithGoogleWithDelegate(delegate: SocialManagerDelegate) {
        self.delegateSocialManager = delegate
        GIDSignIn.sharedInstance().delegate = self

        if let safeDelegate = delegateSocialManager as? UIViewController {
            GIDSignIn.sharedInstance()?.presentingViewController = safeDelegate
            GIDSignIn.sharedInstance().signIn()
        }
    }

    fileprivate func loginWithFacebookWithDelegate(delegate: SocialManagerDelegate) {
        self.delegateSocialManager = delegate

        if let safeDelegate = delegateSocialManager as? UIViewController {
            let fbLoginManager: LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["email", "public_profile"], from: safeDelegate) { (result, error) in
                if error == nil {
                    if let fbloginresult = result {
                        if fbloginresult.isCancelled {
                        } else if fbloginresult.grantedPermissions.contains("email") {
                            self.returnUserData()
                            //fbLoginManager.logOut()
                        }
                    }
                }
            }
        }
    }

    fileprivate func returnUserData() {
        let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "email,name"])
        graphRequest.start(completionHandler: { (_, result, error) -> Void in
            if error != nil {
                // Process error
                print("\n\n Error: \(String(describing: error))")
            } else {
                if let resultDic = result as? NSDictionary {
                    print("\n\n  fetched user: \(String(describing: result))")

                    if let userName = resultDic.value(forKey: "name") as? String {
                        print("\n User Name is: \(userName)")
                    }

                    if let userEmail = resultDic.value(forKey: "email") as? String {
                        print("\n User Email is: \(String(describing: userEmail))")
                    }
                }
            }
            if let safeDelegate = self.delegateSocialManager {
                safeDelegate.didLoginSuccessFully(socialType: SocialLoginType.faceBook)
            }
        })
    }

    fileprivate func loginWithAppleWithDelegate(delegate: SocialManagerDelegate) {
        self.delegateSocialManager = delegate
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension SocialManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        _ = user.userID                  // For client-side use only!
        _ = user.authentication.idToken // Safe to send to the server
        _ = user.profile.name
        _ = user.profile.givenName
        _ = user.profile.familyName
        _ = user.profile.email
        // ...
        if let safeDelegate = self.delegateSocialManager {
            safeDelegate.didLoginSuccessFully(socialType: SocialLoginType.google)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}

extension SocialManager: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            _ = appleIDCredential.user

            _ = appleIDCredential.fullName?.givenName

            _ = appleIDCredential.fullName?.familyName

            _ = appleIDCredential.email

            if let safeDelegate = self.delegateSocialManager {
                safeDelegate.didLoginSuccessFully(socialType: SocialLoginType.apple)
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            _ = passwordCredential.user

            _ = passwordCredential.password

            //Write your code
            if let safeDelegate = self.delegateSocialManager {
                safeDelegate.didLoginSuccessFully(socialType: SocialLoginType.apple)
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\(error.localizedDescription)")
    }
}

extension SocialManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIWindow.init()
    }
}
