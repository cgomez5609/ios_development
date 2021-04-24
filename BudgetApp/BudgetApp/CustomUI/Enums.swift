//
//  Enums.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/8/21.
//

import UIKit

enum Labels: String {
    case username = "Username"
    case password = "Password"
}

func generateLabel(forType type: Labels) -> UILabel {
    switch type {
    case .username:
        let label = UILabel()
        label.text = Labels.username.rawValue
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(20.0)
        label.textAlignment = .center
        return label
    
    case .password:
        let label = UILabel()
        label.text = Labels.password.rawValue
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = label.font.withSize(20.0)
        label.textAlignment = .center
        return label
    }
}

enum TextFields {
    case username
    case password
}

func generateTextField(forType type: TextFields) -> UITextField {
    switch type {
    case .username:
        let field = UITextField()
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: "Enter username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.textColor = .lightGray
        field.textAlignment = .center
        return field
    case .password:
        let field = UITextField()
        field.backgroundColor = .clear
        field.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        field.textColor = .lightGray
        field.keyboardType = .phonePad
        field.textAlignment = .center
        return field
    }
}


enum Alert {
    case usernameAlreadyExists
    case accountCreated
    case incorrectPasswordFormat
    case wrongPassword
}


