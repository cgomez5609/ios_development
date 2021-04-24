//
//  TextFieldComponent.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/8/21.
//

import UIKit

class TextFieldComponent {
    private let type: TextFields
    public let textField: UITextField
    
    public init(forTextFieldType type: TextFields) {
        self.type = type
        self.textField = generateTextField(forType: self.type)
    }
}
