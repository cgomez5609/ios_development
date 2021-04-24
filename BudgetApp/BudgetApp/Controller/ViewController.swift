//
//  ViewController.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/7/21.
//

import UIKit

class ViewController: UIViewController {
    var background = UIImage()
    let mainView = UIView()
    
    var inputOne = TextFieldComponent(forTextFieldType: .username)
    var inputTwo = TextFieldComponent(forTextFieldType: .password)
    
    let coreData = CoreDataManager()
    
    let submitButton = UIButton()
    let signUpButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setBackground()
        
        submitButtonConfiguration()
//        signUpButtonConfiguration()

        mainView.addSubview(inputOne.textField)
        mainView.addSubview(inputTwo.textField)
        mainView.addSubview(submitButton)
        view.addSubview(mainView)
//        view.addSubview(signUpButton)
//        signUpButton.translatesAutoresizingMaskIntoConstraints = false
//        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        mainViewConstraints()
        textFieldConstraints()
        buttonConstraints()

        
    }
    
    private func getBackground() -> UIImage {
        if let image = UIImage(named: "background_budget") {
            return image
        } else {
            fatalError("Could not initialize \(UIImage.self) named \("background_budget").")
        }
    }
    
    private func setBackground() {
        let width = view.bounds.size.width
        let height = view.bounds.size.height

        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.background = self.getBackground()
        imageViewBackground.image = background
        imageViewBackground.contentMode = .scaleAspectFill
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
    
    
    @objc func newUserScreen(sender: UIButton) {
        
        let username = self.inputOne.textField.text ?? "bob"
        let password = Int16(self.inputTwo.textField.text!)
        
        coreData.createNewUser(username: username, password: password!, amount: 13879.23)
        
        coreData.addPurchases(forUsername: username, company: "Amazon", purchaseAmount: 12.45)
        coreData.addPurchases(forUsername: username, company: "Amazon", purchaseAmount: 10.87)
        coreData.addPurchases(forUsername: username, company: "Nike", purchaseAmount: 123.90)
        coreData.addPurchases(forUsername: username, company: "Sony", purchaseAmount: 499.12)
        coreData.addPurchases(forUsername: username, company: "Steam", purchaseAmount: 45.34)
        coreData.addPurchases(forUsername: username, company: "Argo Tea", purchaseAmount: 4.75)
        coreData.addPurchases(forUsername: username, company: "Apple", purchaseAmount: 9.99)
        coreData.addPurchases(forUsername: username, company: "Furniture+", purchaseAmount: 999.99)

        
    }
    
    func submitButtonConfiguration() {
        submitButton.backgroundColor = UIColor(red: 15/255, green: 80/255, blue: 154/255, alpha: 0.9)
        submitButton.layer.cornerRadius = 10.0
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(submitData(sender:)), for: .touchUpInside)
    }
    
    func signUpButtonConfiguration() {
        signUpButton.backgroundColor = .cyan
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.layer.borderWidth = 2.0
        signUpButton.layer.borderColor = UIColor.systemBlue.cgColor
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.addTarget(self, action: #selector(newUserScreen(sender:)), for: .touchUpInside)
    }
    
    @objc func submitData(sender: UIButton) {
        let username = self.inputOne.textField.text ?? "bob"
        let password = Int16(self.inputTwo.textField.text!)


        let newUser = coreData.fetchUser(withUsername: username)
        if newUser != nil {
            if newUser?.password == password {
                let balanceVC = BalanceViewController()
                balanceVC.currentUser = newUser!
                balanceVC.modalPresentationStyle = .fullScreen
                self.present(balanceVC, animated: true, completion: nil)
            } else{
                Alerts.useAlert(for: .wrongPassword, user: username, controller: self)
            }
            
        } else {
            print("not a valid user")
        }
    }

    
    
    func buttonConstraints() {
        let frameHeight = mainView.frame.height
        let middlePadding = frameHeight * 0.05
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: inputTwo.textField.bottomAnchor, constant: middlePadding+5).isActive = true
        submitButton.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.90).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -middlePadding-5).isActive = true
        
    }
    
    func textFieldConstraints() {
        let frameHeight = mainView.frame.height
        let middlePadding = frameHeight * 0.05

        inputOne.textField.translatesAutoresizingMaskIntoConstraints = false
        inputTwo.textField.translatesAutoresizingMaskIntoConstraints = false
        
        print(frameHeight)
        print(middlePadding)
        
        inputOne.textField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        inputOne.textField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: middlePadding).isActive = true
        inputOne.textField.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        inputOne.textField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.25).isActive = true
        inputOne.textField.layoutIfNeeded()
        
        inputTwo.textField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        inputTwo.textField.topAnchor.constraint(equalTo: inputOne.textField.bottomAnchor, constant: middlePadding).isActive = true
        inputTwo.textField.widthAnchor.constraint(equalTo: mainView.widthAnchor).isActive = true
        inputTwo.textField.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.25).isActive = true
        inputTwo.textField.layoutIfNeeded()
        
        let bottomLineOne = CALayer()
        bottomLineOne.frame = CGRect(x: 10, y: (mainView.frame.height * 0.3) - middlePadding, width: mainView.frame.width-20, height: 1.0)
        bottomLineOne.backgroundColor = UIColor.black.cgColor
        inputOne.textField.borderStyle = UITextField.BorderStyle.none
        inputOne.textField.layer.addSublayer(bottomLineOne)
        
        let bottomLineTwo = CALayer()
        bottomLineTwo.frame = CGRect(x: 10, y: (mainView.frame.height * 0.3) - middlePadding, width: mainView.frame.width-20, height: 1.0)
        bottomLineTwo.backgroundColor = UIColor.black.cgColor
        inputTwo.textField.borderStyle = UITextField.BorderStyle.none
        inputTwo.textField.layer.addSublayer(bottomLineTwo)
        
    }
    
    func mainViewConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.layer.borderWidth = 2.0
        mainView.layer.borderColor = UIColor.black.cgColor
        mainView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        mainView.layer.cornerRadius = 15.0
        
        let frameHeight = view.frame.height
        let padding = frameHeight * 0.6
        let bottomPadding = frameHeight * 0.15
        let sidePadding = view.frame.width * 0.05
        
        let constraints = [
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomPadding),
        ]
        
        NSLayoutConstraint.activate(constraints)
        mainView.layoutIfNeeded()
    }
    
}

