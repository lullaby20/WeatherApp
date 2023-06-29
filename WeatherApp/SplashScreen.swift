//
//  SplashScreen.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 20.11.2022.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    
    var body: some View {
        if isActive {
            MainView()
        } else {
            ZStack {
                Color("LaunchScreenBackground")
                    .ignoresSafeArea()
                
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 60)
                    .scaleEffect(size)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 1.1
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
