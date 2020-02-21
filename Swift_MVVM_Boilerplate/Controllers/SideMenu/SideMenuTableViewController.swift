//
//  SideMenuTableViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 10/01/20.
//  Copyright © 2020 Systango. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelFullname: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.layer.cornerRadius = 4.0
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

        imageView.layer.cornerRadius = 45.0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    }

    @IBAction func logoutAction(_ sender: Any) {
        self.showAlert("Logout", message: Constants.Message.logoutWarning, actions: ["Cancel", "Logout"]) { (actionTitle) in
            if actionTitle == "Logout" {
                RedirectionHelper.redirectToLogin()
            }
        }
    }
}
