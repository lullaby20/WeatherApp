//
//  City.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 13.11.2022.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let name: String
    
    static var placeholder: [City] {
        [
            City(name: "Almaty"),
            City(name: "Dubai")
        ]
    }
}
