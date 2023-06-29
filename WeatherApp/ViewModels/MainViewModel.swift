//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 13.11.2022.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var cities = [City]()
    @Published var newCityName = ""
    let date: Date
    var currentDate: String! = nil
    var tabSelection = 1
    
    init() {
        cities = City.placeholder
        
        self.date = Date()
        self.currentDate = formatCurrentDate(date)
    }

    func addCity() {
        cities.append(City(name: newCityName))
    }
    
    func formatCurrentDate(_ string: Date) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: string)
        return dateString
    }
    
    func print() {
        Swift.print(cities)
    }
}

