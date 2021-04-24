//
//  BalanceViewController.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/15/21.
//

import UIKit

class BalanceViewController : UIViewController {
    var currentUser : User?
    var userAccount : AccountInfoComponent!
    
    let black = UIColor.black.cgColor
    let scrollView = UIScrollView()
    let timeLabel = UILabel()
    let accountStackView = UIStackView()
    let date = Date()
    let dateFormatter = DateFormatter()
    let user = 1
    let balanceView = UIView()
    let swipeUp = UISwipeGestureRecognizer()
    let swipeUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 2/255, green: 11/255, blue: 41/255, alpha: 1.0)
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        swipeUp.addTarget(self, action: #selector(self.swipedViewUp))
        swipeUpButton.addGestureRecognizer(swipeUp)

        swipeUpButton.setImage(UIImage(named: "nav-up.png"), for: .normal)
        
        balanceViewSetup()
        view.addSubview(balanceView)
        view.addSubview(swipeUpButton)
        
        balanceViewConstraints()
        setupUserAccountInfo()
        swipeButtonConstraint()
    }
    
    @objc func swipedViewUp() {
        let homeVC = HomeViewController()
        homeVC.currentUser = currentUser
        homeVC.modalPresentationStyle = .fullScreen
        self.present(homeVC, animated: true, completion: nil)
    }
    
    func swipeButtonConstraint() {
        let safeZone = view.safeAreaLayoutGuide
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        let topPadding = viewHeight * 0.875
        let sidePadding = viewWidth * 0.40
        swipeUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        swipeUpButton.topAnchor.constraint(equalTo: safeZone.topAnchor, constant: topPadding).isActive = true
        swipeUpButton.leadingAnchor.constraint(equalTo: safeZone.leadingAnchor, constant: sidePadding).isActive = true
        swipeUpButton.bottomAnchor.constraint(equalTo: safeZone.bottomAnchor).isActive = true
        swipeUpButton.trailingAnchor.constraint(equalTo: safeZone.trailingAnchor, constant: -sidePadding).isActive = true
        
        swipeUpButton.layoutIfNeeded()
    }
    
    func setupUserAccountInfo() {
        self.userAccount = AccountInfoComponent(user: currentUser!)
        
        self.balanceView.addSubview(userAccount.view)
        
        accountInfoConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            self.userAccount.change()
        })
    }
    
    func balanceViewSetup() {
        self.balanceView.layer.borderWidth = 0.0
        self.balanceView.layer.borderColor = UIColor.clear.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: {
            self.balanceView.animateBorderColor(toColor: .cyan, duration: 1.0)
            self.balanceView.animateVorderWidth(toWidth: 2.0, duration: 1.0)
            self.balanceView.layer.cornerRadius = 35.0
        })
        
        
    }
    
    func balanceViewConstraints() {
        let parentViewHeight = view.frame.height
        let parentViewWidth = view.frame.width
        
        let sidePadding = parentViewWidth / 6
        let topBottomPadding = parentViewHeight / 2.75
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        
        balanceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        balanceView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sidePadding).isActive = true
        balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sidePadding).isActive = true
        balanceView.topAnchor.constraint(equalTo: view.topAnchor, constant: topBottomPadding).isActive = true
        balanceView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -topBottomPadding).isActive = true
        
        balanceView.layoutIfNeeded()
    }
    
    func accountInfoConstraints() {
        let parentViewHeight = balanceView.frame.height
        let parentViewWidth = balanceView.frame.width
        
        let sidePadding = parentViewWidth / 4
        let topBottomPadding = parentViewHeight / 4
        
        userAccount.view.translatesAutoresizingMaskIntoConstraints = false
        userAccount.view.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor).isActive = true
        userAccount.view.centerYAnchor.constraint(equalTo: balanceView.centerYAnchor).isActive = true
        userAccount.view.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: topBottomPadding).isActive = true
        userAccount.view.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor, constant: sidePadding).isActive = true
        userAccount.view.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: -topBottomPadding).isActive = true
        userAccount.view.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor, constant: -sidePadding).isActive = true
    }
}

extension UIView {
  func animateBorderColor(toColor: UIColor, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
    animation.fromValue = layer.borderColor
    animation.toValue = toColor.cgColor
    animation.duration = duration
    layer.add(animation, forKey: "borderColor")
    layer.borderColor = toColor.cgColor
  }
}

extension UIView {
  func animateVorderWidth(toWidth: CGFloat, duration: Double) {
    let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    animation.fromValue = layer.borderWidth
    animation.toValue = toWidth
    animation.duration = duration
    layer.add(animation, forKey: "borderWidth")
    layer.borderWidth = toWidth
  }
}
