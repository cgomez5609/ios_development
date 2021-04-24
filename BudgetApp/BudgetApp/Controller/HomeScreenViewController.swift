//
//  HomeScreenViewController.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/11/21.
//
import UIKit
import Charts

class HomeViewController : UINavigationController {
    
    var currentUser : User?
    var view1 : AccountInfoComponent!
    
    let black = UIColor.black.cgColor
    let scrollView = UIScrollView()
    
    let timeView = UIView()
    let timeLabel = UILabel()
    
    let date = Date()
    let dateFormatter = DateFormatter()
    let purchaseTable = UITableView()
    let graphView = UIView()
    
    var purchases = [Purchases]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.backgroundColor = .systemGray
        
        if let p = currentUser!.account!.purchase {
            for item in p as! Set<Purchases> {
                purchases.append(item)
            }
        }
        
        // Do any additional setup after loading the view.
        purchaseTable.backgroundColor = .purple
        purchaseTable.register(CustomTableCell.self, forCellReuseIdentifier: "cell")
        purchaseTable.dataSource = self
        purchaseTable.delegate = self
        
        
        view.backgroundColor = .blue
        dateFormatter.dateFormat = "YY, MMM d, HH:mm:ss"
        
        timeLabel.text = dateFormatter.string(from: date)
        timeView.layer.borderWidth = 2.0
        timeView.layer.borderColor = black
        timeView.backgroundColor = .green
        timeLabel.textAlignment = .center
        timeView.addSubview(timeLabel)
        
            
        scrollView.backgroundColor = .red
        scrollView.layer.borderWidth = 2.0
        scrollView.layer.borderColor = black
        
        
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: 1, height: view.frame.size.height)
        
        addChildrenViews()
        scrollViewConstraints()
        
        labelConstraints()
        accountViewConstraints()
        tableViewConstraints()
        
        setupGraphView()
    }
    
    
    
    func scrollViewConstraints() {
        let viewHeight = view.frame.height
        let bottomPadding = viewHeight * 0.25
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPadding).isActive = true
        
        scrollView.layoutIfNeeded()
    }
    
    
    func accountViewConstraints() {
        let myUser = currentUser!
        self.view1 = AccountInfoComponent(user: myUser)
        self.view1.amountLabel.text = String(myUser.account!.amount)
        
        let safeArea = scrollView.safeAreaLayoutGuide
        scrollView.addSubview(view1.view)
        
        
        let scrollHeight = scrollView.frame.height
        let bottomPadding = scrollHeight * 0.55
        
        print("height", scrollHeight, "padding", bottomPadding)
        
        view1.view.translatesAutoresizingMaskIntoConstraints = false
        view1.view.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 10).isActive = true
        view1.view.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        view1.view.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -bottomPadding).isActive = true
        view1.view.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
    }
    
    func addChildrenViews() {
        scrollView.addSubview(timeView)
        scrollView.addSubview(purchaseTable)
        view.addSubview(graphView)
        view.addSubview(scrollView)
    }
    
    func labelConstraints() {
        let scrollHeight = scrollView.frame.height
        let bottomPadding = scrollHeight * 0.75
        
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor).isActive = true
        timeView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        timeView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: -bottomPadding).isActive = true
        timeView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: timeView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeView.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func tableViewConstraints() {
        let safeArea = scrollView.safeAreaLayoutGuide
        purchaseTable.translatesAutoresizingMaskIntoConstraints = false
        
        purchaseTable.topAnchor.constraint(equalTo: view1.view.bottomAnchor, constant: 10).isActive = true
        purchaseTable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        purchaseTable.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        purchaseTable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    func setupGraphView() {
        let safeArea = view.safeAreaLayoutGuide
        
        graphView.translatesAutoresizingMaskIntoConstraints = false
        graphView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        graphView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        graphView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
        graphView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        

        
    }
}

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableCell
        
        let purchase =  purchases[indexPath.row]
        cell.leftLabel.text = purchase.company
        cell.rightLabel.text = String(purchase.purchaseAmount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // Make the first row larger to accommodate a custom cell.
        return 35

    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

class CustomTableCell : UITableViewCell {
    
    let leftLabel : UILabel = {
        let l = UILabel()
        l.backgroundColor = .orange
        l.textAlignment = .center
        return l
    }()
    
    let rightLabel : UILabel = {
        let l = UILabel()
        l.backgroundColor = .systemPink
        l.textAlignment = .center
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
        labelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func labelConstraints() {
        let viewWidth = self.frame.width
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewWidth/2).isActive = true

        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightLabel.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
}
