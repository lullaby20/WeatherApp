//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 01.11.2022.
//

import SwiftUI

struct HourlyForecastView: View {
    @StateObject var viewModel: HourViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.temp + "°")
                .bold()
                .font(.system(size: 16))
            Image(viewModel.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading, -1)
            Text(viewModel.dateToString)
                .foregroundColor(.gray)
                .font(.system(size: 16))
        }
        .frame(width: 70, height: 116)
        .background(Color("BackgroundColor"))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView(viewModel: .init(model: .init()))
    }
}
