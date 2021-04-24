//
//  NewUserViewController.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/7/21.
//

import UIKit

class NewUserViewController: UIViewController {
    let coreData = CoreDataManager()
    
    var gradient: CAGradientLayer!
    
    let topView = UIView()
    let middleView = UIView()
    let bottomView = UIView()
    
    let userLabel = LabelComponent(labelType: Labels.username)
    let passwordLabel = LabelComponent(labelType: Labels.password)
    var inputOne = TextFieldComponent(forTextFieldType: .username)
    var inputTwo = TextFieldComponent(forTextFieldType: .password)
    var button = UIButton()
    
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureGradient()
        buttonConfiguration()
        
        topView.addSubview(userLabel.label)
        topView.addSubview(inputOne.textField)
        middleView.addSubview(passwordLabel.label)
        middleView.addSubview(inputTwo.textField)
        bottomView.addSubview(button)
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(bottomView)
        stackView.distribution = .fillEqually
    
        view.addSubview(stackView)
        stackConstraints()
        elementConstraints()
    }
    
    @objc func submitData(sender: UIButton) {
        print(inputTwo.textField.text!.count)
        if inputTwo.textField.text!.count != 4 {
            Alerts.useAlert(for: .incorrectPasswordFormat, user: "", controller: self)
        }
        
        if let password = Int16(self.inputTwo.textField.text!)  {
            if let username = inputOne.textField.text {
                let userChecked = coreData.fetchUser(withUsername: username)
                if userChecked == nil {
                    coreData.createNewUser(username: username, password: password, amount: 100.0)
                    Alerts.useAlert(for: .accountCreated, user: username, controller: self)
                } else {
                    Alerts.useAlert(for: .usernameAlreadyExists, user: username, controller: self)
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradient.frame = self.view.bounds
    }
    
    func configureGradient() {
        gradient = CAGradientLayer()
        let colorTop = UIColor(red: 42.0 / 255.0, green: 38.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func buttonConfiguration() {
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10.0
        button.layer.borderWidth = 2.0
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submitData(sender:)), for: .touchUpInside)
    }
    

    // This works because UIViews were placed inside another UIView (In this case StackView) that has to conform to the
    // constraints given to it. Therefore anything inside of it also needs to conform to it. Beautiful!
    func elementConstraints() {
        // username label and input field
        userLabel.label.translatesAutoresizingMaskIntoConstraints = false
        inputOne.textField.translatesAutoresizingMaskIntoConstraints = false
        userLabel.label.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor).isActive = true
        userLabel.label.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        userLabel.label.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.40).isActive = true
        inputOne.textField.topAnchor.constraint(equalTo: userLabel.label.bottomAnchor).isActive = true
        inputOne.textField.widthAnchor.constraint(equalTo: topView.widthAnchor).isActive = true
        inputOne.textField.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.60).isActive = true
        
        // password label and input field
        passwordLabel.label.translatesAutoresizingMaskIntoConstraints = false
        inputTwo.textField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.label.topAnchor.constraint(equalTo: middleView.safeAreaLayoutGuide.topAnchor).isActive = true
        passwordLabel.label.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        passwordLabel.label.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.40).isActive = true
        inputTwo.textField.topAnchor.constraint(equalTo: passwordLabel.label.bottomAnchor).isActive = true
        inputTwo.textField.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        inputTwo.textField.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.60).isActive = true

        // button to submit data
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.60).isActive = true
    }
    
    
    func stackConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.70).isActive = true
        stackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.50).isActive = true
    }
    
}
