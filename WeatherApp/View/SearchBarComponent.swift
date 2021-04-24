import UIKit

protocol locationButtonDelegate {
    func coreLocation()
}

class SearchBarComponent {
    var coreLocationDelegate: locationButtonDelegate?
    
    let view = UIView()
    let coreLocationButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .label
        return button
    }()
    let searchTextField : UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.adjustsFontSizeToFitWidth = true
        field.contentMode = .scaleToFill
        field.backgroundColor = .systemFill
        return field
    }()
    let searchButton : UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.tintColor = .label
        return button
    }()
    
    public init() {
        view.addSubview(coreLocationButton)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        
        
        coreLocationButton.addTarget(self, action: #selector(coreLocationButtonPressed(button:)), for: .touchUpInside)
        searchTextField.placeholder = "search"
        searchButton.addTarget(self, action: #selector(searchButtonPressed(button:)), for: .touchUpInside)
    }
    
    public func activateConstraints() {
        self.coreButtonConstraints()
        self.textFieldConstraints()
        self.searchButtonConstraints()
    }
    
    private func coreButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let viewWidth = view.frame.width
        let sidePadding = viewWidth * 0.85
        
        coreLocationButton.translatesAutoresizingMaskIntoConstraints = false
        coreLocationButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        coreLocationButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        coreLocationButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        coreLocationButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sidePadding).isActive = true
    }
    
    private func textFieldConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let viewWidth = view.frame.width
        let sidePadding = viewWidth * 0.15
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: coreLocationButton.trailingAnchor).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -sidePadding).isActive = true
    }
    
    private func searchButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: searchTextField.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    @objc private func searchButtonPressed(button: UIButton) {
        print(self.searchTextField.text ?? "N/A")
        searchTextField.endEditing(true)
    }
    
    @objc private func coreLocationButtonPressed(button: UIButton) {
        let homeVC = HomeViewController()
        print(homeVC.lat)
//        homeVC.weatherManager.fetchWeather(lat: homeVC.lat, lon: homeVC.lon)
        self.coreLocationDelegate?.coreLocation()
    }
}
