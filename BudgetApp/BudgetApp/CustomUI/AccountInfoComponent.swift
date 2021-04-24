//
//  AccountInfoComponent.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/12/21.
//

import UIKit

class AccountInfoComponent {
    public let view = UIView()
    public let amountLabel = UILabel()
    private let balance : Double
    private var currentCount :  Double = 0.0
    
    private let user : User
    
    public init(user: User) {
        self.user = user
        self.balance = user.account!.amount
        self.setupView()
    }
    
    private func setupView() {
        view.addSubview(amountLabel)
        
        setupLabel()
        labelConstraints()
    }
    
    private func setupLabel() {
        amountLabel.textColor = .white
        amountLabel.font = UIFont(name: "Bodoni 72", size: 30.0)
    }
    
    private func labelConstraints() {
        amountLabel.backgroundColor = .clear
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        amountLabel.adjustsFontSizeToFitWidth = true
    }
    
    func change() {
        if self.currentCount / self.balance < 0.7 {
            self.currentCount += self.balance * 0.01
        } else if self.currentCount / self.balance < 0.9 {
            self.currentCount += self.balance * 0.005
        } else if self.currentCount / self.balance < 0.95 {
            self.currentCount += self.balance * 0.001
        } else {
            self.currentCount += self.balance * 0.0001
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.amountLabel.text = String(format: "%.2f", self.currentCount)
        }, completion: { done in
            if done {
                if self.currentCount < self.balance {
                    self.add()
                } else {
                    self.amountLabel.text = String(format: "%.2f", self.currentCount)
                }
            }
        })
    }
    
    private func add() {
        if self.currentCount / self.balance < 0.7 {
            self.currentCount += self.balance * 0.01
        } else if self.currentCount / self.balance < 0.9 {
            self.currentCount += self.balance * 0.005
        } else if self.currentCount / self.balance < 0.95 {
            self.currentCount += self.balance * 0.001
        } else {
            self.currentCount += self.balance * 0.0001
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.amountLabel.text = String(format: "%.2f", self.currentCount)
        }, completion: { none in
            if self.currentCount < self.balance {
                self.change()
            } else {
                self.amountLabel.text = String(format: "%.2f", self.currentCount)
            }
        })
    }
}
