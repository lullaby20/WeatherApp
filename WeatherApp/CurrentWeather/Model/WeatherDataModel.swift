//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 10.11.2022.
//

import Foundation

struct WeatherDataModel: Decodable {
    let currentConditions: CurrentConditions
    let days: [DayWeek]
    
    enum CodingKeys: String, CodingKey {
        case days
        case currentConditions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentConditions = try container.decode(CurrentConditions.self, forKey: .currentConditions)
        days = try container.decode([DayWeek].self, forKey: .days)
    }
}

struct CurrentConditions: Decodable {
    let datetime: String
    let temp: Double
    let humidity: Double
    let windspeed: Double
    let cloudcover: Double
    let conditions: String
    let icon: String
}

struct DayWeek: Decodable {
    let datetime: String
    let tempmax: Double
    let tempmin: Double
    let conditions: String
    let icon: String
    
    init() {
        datetime = "2022-11-14"
        tempmax = 10.0
        tempmin = 10.0
        conditions = "Sunny"
        icon = "sunny"
    }
}
