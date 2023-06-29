//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 08.11.2022.
//

import Foundation

final class DayForecastViewModel: ObservableObject, Hashable, Identifiable {
    private(set) var id = UUID()
    @Published var model: DayWeek
    let getIconUseCase = GetIconUseCase()
    
    var fullDate: Date {
        dateFormatFull(date: model.datetime)
    }
    
    var date: String {
        weekDayFormat(from: fullDate)
    }
    
    var icon: String {
        getIconUseCase.getIcon(from: model.icon)
    }
    
    var conditions: String {
        removeChar(word: model.conditions)
    }
    
    var tempMax: String {
        "\(Int(model.tempmax))"
    }
    
    var tempMin: String {
        "\(Int(model.tempmin))"
    }
    
    
    init(model: DayWeek) {
        self.model = model
    }
    
    static func == (lhs: DayForecastViewModel, rhs: DayForecastViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func removeChar(word: String) -> String {
        let index = word.firstIndex(of: ",") ?? word.endIndex
        let beginning = word[..<index]
        let result = String(beginning)
        return result
    }
    
    func dateFormatFull(date : String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           dateFormatter.timeZone = .current
           dateFormatter.locale = NSLocale(localeIdentifier: "en_GB") as Locale
           return dateFormatter.date(from: date) ?? Date.now
       }
    
    func weekDayFormat(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date)
    }
}
