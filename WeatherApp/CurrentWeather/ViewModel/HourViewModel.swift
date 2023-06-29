//
//  HourViewModel.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 11.11.2022.
//

import Foundation

final class HourViewModel: ObservableObject, Hashable {
    static func == (lhs: HourViewModel, rhs: HourViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    let getIconUseCase = GetIconUseCase()
    
    private(set) var id = UUID()
    
    @Published var model: Hour
    
    var temp: String {
        "\(Int(model.temp))"
    }
    
    var icon: String {
        getIconUseCase.getIcon(from: model.icon)
    }
    
    var stringToDate: Date {
        dateFormatTime(date: model.datetime)
    }
    
    var dateToString: String {
        timeIn24HourFormat(from: stringToDate)
    }
    
    init(model: Hour) {
        self.model = model
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    func dateFormatTime(date : String) -> Date {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "HH:mm:ss"
           dateFormatter.timeZone = .current
           dateFormatter.locale = NSLocale(localeIdentifier: "en_GB") as Locale
           return dateFormatter.date(from: date) ?? Date.now
       }
    
    func timeIn24HourFormat(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
