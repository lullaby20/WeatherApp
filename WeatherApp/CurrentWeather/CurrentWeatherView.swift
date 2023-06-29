//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 03.11.2022.
//

import SwiftUI

struct CurrentWeatherView: View {
    @StateObject var currentWeatherViewModel: CityWeatherViewModel
    @StateObject var hourlyViewModel: DayViewModel

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
             
            VStack {
                VStack {
                    Button(action: {
                        currentWeatherViewModel.showSheet.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "mappin")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .bold()
                            Text(currentWeatherViewModel.cityName)
                                .foregroundColor(.white)
                                .font(.system(size: 28)).bold()
                            Image(systemName: "chevron.down")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .bold()
                        }
                        .padding(.top)
//                        .sheet(isPresented: $currentWeatherViewModel.showSheet) {
//                            AddCityView(showSheet: $currentWeatherViewModel.showSheet)
//                        }
                    })
                    
                    Image(currentWeatherViewModel.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 220)
                        .padding(.top, -35)
                        .padding(.leading, -15)
                        .unredacted()
                    Text(currentWeatherViewModel.temp + "°")
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 80))
                        .padding(.top, -50)
                        .padding(.leading, 25)
                    Text(currentWeatherViewModel.condition)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Text("\(Date.now, style: .date)")
                            .foregroundColor(.white)
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 280,height: 0.7)
                    
                    HStack(spacing: 40) {
                        VStack {
                            Image("Humidity")
                                .unredacted()
                            Text(currentWeatherViewModel.humidity + "%")
                                .foregroundColor(.white)
                                .bold()
                            Text("Humidity")
                                .foregroundColor(.gray)
                                .unredacted()
                        }
                        .padding(.top, 13)
                        
                        VStack {
                            Image("Wind")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 24)
                                .unredacted()
                            Text(currentWeatherViewModel.windspeed + " km/h")
                                .foregroundColor(.white)
                                .bold()
                            Text("Wind")
                                .foregroundColor(.gray)
                                .unredacted()
                        }
                        .padding(.top, 8)
                        
                        VStack {
                            Image("CloudCover")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .unredacted()
                            Text(currentWeatherViewModel.cloudcover + "%")
                                .foregroundColor(.white)
                                .bold()
                            Text("Clouds")
                                .foregroundColor(.gray)
                                .unredacted()
                        }
                        .padding(.top, 8)
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 490)
                .background(Color("MainColor"))
                .cornerRadius(40)
                .shadow(radius: 10)
                .padding(.top)
                .redacted(reason: currentWeatherViewModel.isLoading ? .placeholder : .init())
                
                HStack {
                    Text("Today")
                        .font(.system(size: 25))
                        .bold()
                    Spacer()
                    
                    NavigationLink(destination: ForecastView(viewModel: .init(cityName: currentWeatherViewModel.cityName))) {
                        Text("Next 7 days")
                            .foregroundColor(.primary)
                            .font(.system(size: 16))
                        Image(systemName: "chevron.right")
                            .foregroundColor(.primary)
                            .font(.system(size: 17))
                    }
                }
                .padding(.horizontal, 18)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(hourlyViewModel.hourViewModels, id: \.self) { viewModel in
                            HourlyForecastView(viewModel: viewModel)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 150)
                .background(Color("MainColor"))
                .cornerRadius(40)
                .shadow(radius: 10)
                Spacer()
            }
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(currentWeatherViewModel: .init(cityName: "Almaty"), hourlyViewModel: .init(cityName: "Almaty", date: "2022-11-11"))
    }
}
