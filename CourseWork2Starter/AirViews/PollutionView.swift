//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    // @EnvironmentObject and @State varaibles here
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text("\((Int)(modelData.forecast!.current.temp))ºC")
                    .font(.largeTitle)
                
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                    
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                }
                
                HStack {
                    Spacer()
                    Text("H: \((Int)(modelData.forecast!.daily[0].temp.max))ºC")
                    Spacer()
                    Text("Low: \((Int)(modelData.forecast!.daily[0].temp.min))ºC")
                    Spacer()
                }
                
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                    .padding(.bottom, 30.0)
                
                Text("Air Quality Data:")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                HStack(spacing: 10) {
                    VStack {
                        Image("so2")
                            .resizable()
                            .padding(.bottom)
                            .scaledToFit()
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.so2 ?? 0))
                    }
                    Spacer()
                    VStack {
                        Image("no")
                            .resizable()
                            .padding(.bottom)
                            .scaledToFit()
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.no ?? 0))
                    }
                    Spacer()
                    VStack {
                        Image("voc")
                            .resizable()
                            .padding(.bottom)
                            .scaledToFit()
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.nh3 ?? 0))
                    }
                    Spacer()
                    VStack {
                        Image("pm")
                            .resizable()
                            .padding(.bottom)
                            .scaledToFit()
                        Text(String(format: "%.2f", modelData.airPollution?.list[0].components.pm2_5 ?? 0))
                    }
                }
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.4)
            .padding()
        }
        .onAppear {
            Task {
                try await modelData.LoadAirPollutionData()
            }
        }
    }
}
