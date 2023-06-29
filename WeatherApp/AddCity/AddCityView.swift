//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Daniyar Merekeyev on 04.11.2022.
//

import SwiftUI

struct AddCityView: View {
    @State private var isSearching = false
    @EnvironmentObject var viewModel: MainViewModel
//    @Binding var showSheet: Bool
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15))
                        .padding(.leading)
                        .padding(.vertical)
                        .foregroundColor(.white)
                    TextField("Search for a city", text: $viewModel.newCityName)
                        .foregroundColor(.white)
                        .padding(.vertical)
        
                    if isSearching {
                        Button(action: {
                            isSearching = false
                            viewModel.newCityName = ""
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding(.trailing)
                                .padding(.leading, -10)
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.spring(), value: 25)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .background(Color("MainColor"))
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.top, 30)
                .onTapGesture {
                    isSearching = true
                }
                Spacer()
                
                Button(action: {
                    viewModel.addCity()
                    viewModel.print()
//                    showSheet = false
                }, label: {
                    Text("Add new city")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width * 0.9)
                        .background(Color("MainColor"))
                        .cornerRadius(15)
                        .padding(.bottom, 25)
                })
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}
//
//struct AddCityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCityView()
//    }
//}
