//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
        
            VStack {
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                
                VStack(spacing: 20) {
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
                    
                    HStack {
                        Text("Wind Speed:  \((Int)(modelData.forecast!.current.windSpeed))m/s")
                            .font(.title3)
                        Spacer()
                        Text("Direction:  \(convertDegToCardinal(deg: modelData.forecast!.current.windDeg))")
                            .font(.title3)
                    }.padding(.bottom, 30.0)
                    
                    HStack {
                        Text("Humidity:  \((Int)(modelData.forecast!.current.humidity))%")
                            .font(.title3)
                        Spacer()
                        Text("Pressure:  \((Int)(modelData.forecast!.current.pressure))hPg").font(.title3)
                    }
                    
                    HStack {
                        Label {
                            Text(Date(timeIntervalSince1970: TimeInterval((Int)(modelData.forecast!.current.sunrise ?? 0))).formatted(.dateTime.hour().minute()))
                        } icon: {
                            Image(systemName: "sunrise.fill")
                                .foregroundColor(.yellow)
                        }
                        .font(.title3)
                        
                        
                        Label {
                            Text(Date(timeIntervalSince1970: TimeInterval((Int)(modelData.forecast!.current.sunset ?? 0))).formatted(.dateTime.hour().minute()))
                        } icon: {
                            Image(systemName: "sunrise.fill")
                                .foregroundColor(.yellow)
                        }
                        .font(.title3)
                    }
                }.padding()
                
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
