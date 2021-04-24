import Foundation


enum Condition : String {
    case normal = "cloud"
    case thunder = "cloud.bolt"
    case drizzle = "cloud.drizzle"
    case rain = "cloud.rain"
    case snow = "cloud.snow"
    case fog = "cloud.fog"
    case sunny = "sun.max"
}

class WeatherModel {
    let conditionID: Int
    let cityName: String
    private let rawTemp: Double
    var temp: String {
        return String(format: "%.1f", self.rawTemp)
    }
    var condition : String {
        return getCondition(id: self.conditionID).rawValue
    }
    
    public init(data: WeatherData) {
        conditionID = data.weather[0].id
        cityName = data.name
        rawTemp = data.main.temp
        print(conditionID, cityName, temp, condition)
    }
    
    private func getCondition(id: Int) -> Condition {
        switch id {
        case 200...232:
            return .thunder
        case 300...321:
            return .drizzle
        case 500...531:
            return .rain
        case 600...622:
            return .snow
        case 701...781:
            return .fog
        case 800:
            return .sunny
        case 801...804:
            return .thunder
        default:
            return .normal
        }
    }
}


