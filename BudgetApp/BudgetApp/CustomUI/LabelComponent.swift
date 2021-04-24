//
//  Labels.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/8/21.
//

import UIKit

class LabelComponent {
    private let type : Labels
    public let label : UILabel
    
    public init(labelType type: Labels) {
        self.type = type
        self.label = generateLabel(forType: self.type)
    }
}
