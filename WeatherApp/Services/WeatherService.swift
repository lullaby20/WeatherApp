//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 06.11.2022.
//

import Combine
import Foundation

struct WeatherService {
    static func getWeatherData(cityName: String) -> AnyPublisher<WeatherDataModel, Error> {
        let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(cityName)?unitGroup=metric&key=\(Statics.apiKey)&contentType=json")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: WeatherDataModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func getHourData(cityName: String, date: String) -> AnyPublisher<[Hour], Error> {
        let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(cityName)/\(date)?unitGroup=metric&key=\(Statics.apiKey)")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: HourDataModel.self, decoder: JSONDecoder())
            .map {
                $0.day.hours
            }
            .eraseToAnyPublisher()
    }
    
    static func getWeekData(cityName: String) -> AnyPublisher<[DayWeek], Error> {
        let url = URL(string: "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(cityName)?unitGroup=metric&key=\(Statics.apiKey)&contentType=json")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: WeatherDataModel.self, decoder: JSONDecoder())
            .map {
                $0.days
            }
            .eraseToAnyPublisher()
    }
}
