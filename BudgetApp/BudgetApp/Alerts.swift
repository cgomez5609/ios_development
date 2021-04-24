//
//  Alerts.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/10/21.
//

import Foundation
import UIKit

struct Alerts {
    
    public static func useAlert(for type: Alert, user: String, controller: UIViewController) {
        switch type {
        
        case .usernameAlreadyExists:
            let usernameExistsAlerts = UIAlertController(title: "Hi", message: "\(user) already exists", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
                print("tapped dismissed username exists")
            }
            usernameExistsAlerts.addAction(alertAction)
            controller.present(usernameExistsAlerts, animated: true)
            
        case .accountCreated:
            let usernameExistsAlerts = UIAlertController(title: "Hi", message: "\(user) has been created. Login", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Go to Login", style: .cancel) { (action) in
                print("tapped dismissed account created and return to log in")
                let loginViewController = ViewController()
                controller.present(loginViewController, animated: true, completion: nil)
            }
            usernameExistsAlerts.addAction(alertAction)
            controller.present(usernameExistsAlerts, animated: true)
            
        case .incorrectPasswordFormat:
            let passwordAlert = UIAlertController(title: "Hi", message: "Password must be four digits", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
                print("tapped dismissed inccorect password format")
            }
            passwordAlert.addAction(alertAction)
            controller.present(passwordAlert, animated: true)
        
        case .wrongPassword:
            let passwordAlert = UIAlertController(title: "Hi", message: "Password does not match for \(user)", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .cancel) { (action) in
                print("tapped dismissed inccorect password")
            }
            passwordAlert.addAction(alertAction)
            controller.present(passwordAlert, animated: true)
        }
    }
}
