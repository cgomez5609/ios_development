import Foundation

struct WeatherData: Decodable {
    let name : String
    let main: Main
    let weather: Array<Weather>
    let sys: Country
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let description: String
}

struct Country: Decodable {
    let country: String
}

