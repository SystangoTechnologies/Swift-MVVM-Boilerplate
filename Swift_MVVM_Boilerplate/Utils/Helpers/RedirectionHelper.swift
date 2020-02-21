//
//  RedirectionHelper.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 09/01/20.
//  Copyright © 2020 Systango. All rights reserved.
//

import UIKit

struct RedirectionHelper {
    static func redirectToLogin() {
        DispatchQueue.main.async {
            let dashboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            UIApplication.shared.windows.first?.rootViewController = dashboardVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }

    static func redirectToDashboard() {
        DispatchQueue.main.async {
            let dashboardVC = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController()
            UIApplication.shared.windows.first?.rootViewController = dashboardVC
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
