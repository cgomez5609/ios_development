import UIKit

struct WeatherDescriptionComponent {
    let view = UIView()
    let conditionView : UIImageView = {
        let tempView = UIImageView()
        tempView.contentMode = .scaleAspectFit
        tempView.tintColor = .label
        return tempView
    }()
    let tempView : UIView = {
        let tempView = UIView()
        return tempView
    }()
    let cityView : UIView = {
        let tempView = UIView()
        tempView.sizeToFit()
        return tempView
    }()
    
    private var conditionImage : UIImage? = {
        if let image = UIImage(systemName: "cloud") {
            return image
        }
        return nil
    }()
    
    private var _tempLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(70.0)
        label.text = "24.5°F"
        label.adjustsFontSizeToFitWidth = true
        label.tintColor = .label
        return label
    }()
    
    let cityLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30.0)
        label.text = "Boulder"
        label.tintColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    public func setTemp(newTemp: String) {
        self._tempLabel.text = newTemp + "°F"
    }
    
    public func setCity(newCity: String) {
        self.cityLabel.text = newCity
    }
    
    public func setConditionImage(with condition: String) {
        self.conditionView.image = UIImage(systemName: condition)
    }
    
    public func setupViewComponentConstraints() {
        view.addSubview(conditionView)
        view.addSubview(tempView)
        view.addSubview(cityView)
        
        let safeArea = view.safeAreaLayoutGuide
        let viewHeight = view.frame.height
        let viewWidth = view.frame.width
        
        conditionView.translatesAutoresizingMaskIntoConstraints = false
        tempView.translatesAutoresizingMaskIntoConstraints = false
        cityView.translatesAutoresizingMaskIntoConstraints = false
        
        conditionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        conditionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: viewWidth * 0.70).isActive = true
        conditionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -(viewHeight*0.70)).isActive = true
        conditionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        tempView.topAnchor.constraint(equalTo: conditionView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tempView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: viewWidth * 0.40).isActive = true
        tempView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -(viewHeight*0.30)).isActive = true
        tempView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        
        cityView.topAnchor.constraint(equalTo: tempView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        cityView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: viewWidth * 0.60).isActive = true
        cityView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        cityView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    public func setupLabelConstraints() {
        conditionView.image = conditionImage
        
        tempView.addSubview(_tempLabel)
        _tempLabel.translatesAutoresizingMaskIntoConstraints = false
        _tempLabel.trailingAnchor.constraint(equalTo: tempView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        cityView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.trailingAnchor.constraint(equalTo: cityView.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}
