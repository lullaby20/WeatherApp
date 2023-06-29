//
//  HourViewModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 11.11.2022.
//

import Combine
import SwiftUI

final class DayViewModel: ObservableObject {
    @Published private(set) var hourViewModels: [HourViewModel] = []
    @Published var cityName: String
    @Published var date: String
    private var cancellables = Set<AnyCancellable>()
    
    init(cityName: String, date: String) {
        self.cityName = cityName
        self.date = date
        
        load()
    }
    
    func load() {
        WeatherService
            .getHourData(cityName: cityName, date: date)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished: return
                }
            } receiveValue: { [weak self] (hoursModel) in
                DispatchQueue.main.async {
                    self?.hourViewModels = hoursModel.map { .init(model: $0) }
                }
            }
            .store(in: &cancellables)
    }
}
