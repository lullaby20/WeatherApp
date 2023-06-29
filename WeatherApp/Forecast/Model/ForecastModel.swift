//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 08.11.2022.
//

import Foundation

struct ForecastModel: Decodable {
    let dt: Int
    let main: Main
    let weather: Weather
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        dt = try container.decode(Int.self, forKey: .dt)
        main = try container.decode(Main.self, forKey: .main)
        let weathers = try container.decode([Weather].self, forKey: .weather)
        self.weather = weathers.first!
    }
    
    init() {
        dt = 1000000
        main = Main(temp_min: 20, temp_max: 34)
        weather = Weather(main: "Sunny", description: "Sunny")
    }
}

struct Elements: Decodable {
    let dt: Int
    let main: Main
    let weather: Weather
}

struct Main: Decodable {
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct WeatherWeekModel: Decodable {
    let list: [ForecastModel]
}

