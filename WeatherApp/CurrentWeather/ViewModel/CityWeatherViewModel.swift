//
//  CityWeatherModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 10.11.2022.
//

import Combine
import SwiftUI

final class CityWeatherViewModel: ObservableObject {
    @Published var cityName: String
    @Published var weatherData: WeatherDataModel?
    @Published var showSheet = false
    private var cancellables = Set<AnyCancellable>()
    let getIconUseCase = GetIconUseCase()
    
    var isLoading: Bool {
        weatherData?.currentConditions.temp == nil
    }
    
    var temp: String {
        "\(Int(weatherData?.currentConditions.temp ?? 100))"
    }
    
    var humidity: String {
        "\(Int(weatherData?.currentConditions.humidity ?? 0))"
    }
    
    var windspeed: String {
        "\(Int(weatherData?.currentConditions.windspeed ?? 0))"
    }
    
    var cloudcover: String {
        "\(Int(weatherData?.currentConditions.cloudcover ?? 0))"
    }
    
    var condition: String {
        weatherData?.currentConditions.conditions ?? "Sunny"
    }
    
    var icon: String {
        getIconUseCase.getIcon(from: weatherData?.currentConditions.icon ?? "nil")
    }
    
    var datetime: String {
        weatherData?.currentConditions.datetime ?? ""
    }
    
    init(cityName: String) {
        self.cityName = cityName
        
        load()
    }
    
    func load() {
        WeatherService
            .getWeatherData(cityName: cityName)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished: return
                }
            } receiveValue: { [weak self] (weatherData) in
                self?.weatherData = weatherData
            }
            .store(in: &cancellables)
    }
}
