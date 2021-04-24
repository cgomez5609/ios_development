import UIKit
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}

struct WeatherManager {
    let code = ""
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=imperial&appid=\(self.code)"
        performRequest(urlString: url)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(self.code)"
        performRequest(urlString: url)
    }
    
    private func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil {
                    print("could not complete task")
                    return
                }
                
                if let unwrappedData = data {
                    if let weatherStats = self.parseJSON(urlData: unwrappedData) {
                        self.delegate?.didUpdateWeather(self, weather: weatherStats)
                    }
                    
                }
            })
            task.resume()
        } else {
            print("Not a valid url")
        }
    }
    
    private func parseJSON(urlData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: urlData)
            let weatherStats = WeatherModel(data: decodedData)
            return weatherStats
        } catch {
            print("could not parse data")
            return nil
        }
    }
    
    
}




