//
//  ContentView.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 01.11.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                TabView(selection: $viewModel.tabSelection) {
                    AddCityView().tag(0)
                    ForEach(viewModel.cities) { city in
                        CurrentWeatherView(currentWeatherViewModel: .init(cityName: city.name), hourlyViewModel: .init(cityName: city.name, date: viewModel.currentDate))
                            .tag(1)
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
            }
        }
        .tint(.primary)
        .environmentObject(viewModel)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
