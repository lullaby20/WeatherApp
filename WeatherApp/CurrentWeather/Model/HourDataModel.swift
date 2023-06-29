//
//  HourDataModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 11.11.2022.
//

import Foundation

struct HourDataModel: Decodable {
    let day: Day
    
    enum CodingKeys: String, CodingKey {
        case days
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let days = try container.decode([Day].self, forKey: .days)
        self.day = days.first!
    }
}

struct Day: Decodable {
    let hours: [Hour]
}

struct Hour: Decodable {
    let datetime: String
    let temp: Double
    let icon: String
    
    init() {
        datetime = "2022-11-11"
        temp = 10.0
        icon = "Sunny"
    }
}
