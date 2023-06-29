//
//  WeekViewModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 08.11.2022.
//

import Foundation
import Combine

final class ForecastViewModel: ObservableObject {
    @Published var dayForecastViewModels: [DayForecastViewModel] = []
    @Published var dayForecastNextViewModels: [DayForecastViewModel] = []
    @Published var cityName: String
    private var cancellables = Set<AnyCancellable>()
    let getIconUseCase = GetIconUseCase()

    init(cityName: String) {
        self.cityName = cityName

        getWeekData()
    }
    
    var isLoading: Bool {
        return dayForecastViewModels.isEmpty
    }
    
    var tmrwIcon: String {
        guard dayForecastViewModels.indices.contains(1) else { return "nil" }
        return dayForecastViewModels[1].icon
    }
    
    var tmrwTempMax: String {
        guard dayForecastViewModels.indices.contains(1) else { return "nil" }
        return dayForecastViewModels[1].tempMax
    }
    
    var tmrwTempMin: String {
        guard dayForecastViewModels.indices.contains(1) else { return "nil" }
        return "/" + dayForecastViewModels[1].tempMin + "°"
    }
    
    var tmrwCondition: String {
        guard dayForecastViewModels.indices.contains(1) else { return "nil" }
        return dayForecastViewModels[1].conditions
    }

    func getWeekData() {
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
            } receiveValue: { [weak self] (weatherWeekModel) in
                guard let self = self else { return }
                self.dayForecastViewModels = weatherWeekModel.days.map { .init(model: $0) }
                
                self.dayForecastNextViewModels = []
                for (index, viewModel) in self.dayForecastViewModels.enumerated() {
                    if index < 2 {
                        continue
                    }
                    
                    self.dayForecastNextViewModels.append(viewModel)
                }
            }
            .store(in: &cancellables)
    }
}
