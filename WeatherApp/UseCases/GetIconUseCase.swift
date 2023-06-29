//
//  GetIconUseCase.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 15.12.2022.
//

import Foundation

protocol GetIcon {
    func getIcon(from string: String) -> String
}

struct GetIconUseCase: GetIcon {
    func getIcon(from icon: String) -> String {
        switch icon {
        case "clear-day":
            return "Clear"
        case "partly-cloudy-day":
            return "Cloudy"
        case "partly-cloudy-night":
            return "CloudyNight"
        case "cloudy":
            return "Overcast"
        case "rain":
            return "Rain"
        case "clear-night":
            return "ClearNight"
        case "overcast":
            return "Overcast"
        case "snow":
            return "Snow"
        case "Clear":
            return "Clear"
        default:
            return "Sunny"
        }
    }
}
