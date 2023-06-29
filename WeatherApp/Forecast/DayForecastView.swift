//
//  7DayForeCast.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 02.11.2022.
//

import SwiftUI

struct DayForecastView: View {
    @StateObject var viewModel: DayForecastViewModel
    
    var body: some View {
            HStack {
                HStack {
                    Text(viewModel.date)
                        .bold()
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                HStack {
                    Image(viewModel.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.top, 2)
                    Text(viewModel.conditions)
                        .bold()
                        .foregroundColor(.gray)
                        .font(.system(size: 20))
                }
                
                Spacer()
                
                HStack {
                    Text(viewModel.tempMax + "°")
                        .bold()
                        .font(.system(size: 18))
                        .padding(.top, 3)
                    Text(viewModel.tempMin + "°")
                        .bold()
                        .foregroundColor(.gray)
                        .font(.system(size: 17))
                        .padding(.top, 5)
                        .padding(.leading, -4)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, alignment: .leading)
            .ignoresSafeArea()
    }
}

struct DayForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DayForecastView(viewModel: .init(model: .init()))
    }
}
