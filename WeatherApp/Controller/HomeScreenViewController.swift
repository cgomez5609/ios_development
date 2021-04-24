import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let searchBar = SearchBarComponent()
    var weatherManager = WeatherManager()
    let weatherdescription = WeatherDescriptionComponent()
    
    let locationManager = CLLocationManager()
    var lat = CLLocationDegrees()
    var lon = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        searchBar.coreLocationDelegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // Do any additional setup after loading the view.
        self.setBackground()
        
        view.addSubview(searchBar.view)
        view.addSubview(weatherdescription.view)
        
        searchBarConstraints()
        searchBar.activateConstraints()
        weatherDescriptionConstraints()
        weatherdescription.setupViewComponentConstraints()
        weatherdescription.setupLabelConstraints()
    }

    private func getBackground(imageName: String) -> UIImage {
        if let image = UIImage(named: imageName) {
            return image
        } else {
            fatalError("Could not initialize \(UIImage.self) named \(imageName).")
        }
    }
    
    private func setBackground() {
        let width = view.bounds.size.width
        let height = view.bounds.size.height
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        let background = self.getBackground(imageName: "background")
        imageViewBackground.image = background
        imageViewBackground.contentMode = .scaleAspectFill
        
        view.addSubview(imageViewBackground)
        view.sendSubviewToBack(imageViewBackground)
    }
    
    private func searchBarConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let viewHeight = view.frame.height
        let bottomPadding = viewHeight * 0.85
        let bar = searchBar.view
        
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        bar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        bar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -bottomPadding).isActive = true
        bar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        bar.layoutIfNeeded()
    }
    
    private func weatherDescriptionConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let viewHeight = view.frame.height
        let bottomPadding = viewHeight * 0.40
        let desc = weatherdescription.view
        let bar = searchBar.view
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.topAnchor.constraint(equalTo: bar.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        desc.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        desc.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -bottomPadding).isActive = true
        desc.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        desc.layoutIfNeeded()
    }
    
}

extension HomeViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchBar.searchTextField.text!)
        searchBar.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchBar.searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchBar.searchTextField.text = ""
        searchBar.searchTextField.placeholder = "search"
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            searchBar.searchTextField.placeholder = "enter some text"
            return false
        }
    }
}

extension HomeViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherdescription.setTemp(newTemp: weather.temp)
            self.weatherdescription.setCity(newCity: weather.cityName)
            self.weatherdescription.setConditionImage(with: weather.condition)
        }
    }
}

extension HomeViewController :  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = locations.last {
            locationManager.stopUpdatingLocation()
            self.lat = location.coordinate.latitude
            self.lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, lon: lon)
       }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController : locationButtonDelegate {
    func coreLocation() {
        locationManager.requestLocation()
        weatherManager.fetchWeather(lat: lat, lon: lon)
    }
}

