//
//  7DayForecastView.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 02.11.2022.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel: ForecastViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Image(viewModel.tmrwIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 170, height: 180)
                                .padding(.leading, -40)
                            
                            VStack {
                                Text("Tomorrow")
                                    .bold()
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                    .padding(.bottom, -15)
                                HStack {
                                    Text(viewModel.tmrwTempMax)
                                        .bold()
                                        .font(.system(size: 45))
                                        .foregroundColor(.white)
                                    Text(viewModel.tmrwTempMin)
                                        .bold()
                                        .foregroundColor(.gray)
                                        .font(.system(size: 23))
                                        .padding(.top)
                                        .padding(.leading, -5)
                                }
                                .unredacted()
                                .frame(width: 110, alignment: .leading)
                                
                                Text(viewModel.tmrwCondition)
                                    .foregroundColor(.gray)
                                    .frame(width: 110, alignment: .leading)
                                    .font(.system(size: 20))
                            }
                            .padding(.top, -5)
                        }
                        .redacted(reason: viewModel.isLoading ? .placeholder : .init())
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                        .background(Color("MainColor"))
                        .cornerRadius(40)
                        .shadow(radius: 10)
                    
                        ForEach(viewModel.dayForecastNextViewModels) { viewModel in
                            DayForecastView(viewModel: viewModel)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: .init(cityName: "Almaty"))
    }
}
