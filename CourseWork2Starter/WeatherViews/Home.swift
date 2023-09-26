//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
            
            VStack {
                Button {
                    self.isSearchOpen.toggle()
                } label: {
                    Text("Change Location")
                        .bold()
                        .font(.system(size: 30))
                }
                .padding(.top, 40.0)
                .sheet(isPresented: $isSearchOpen) {
                    SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                }
                
                Spacer()
                
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity: \((Int)(modelData.forecast!.current.humidity))%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure: \((Int)(modelData.forecast!.current.pressure))hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png"))
                    
                    Text("\(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.black)
                }
                
            }
            .onAppear {
                Task.init {
                    self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    self.modelData.userLocation = userLocation
                }
                
            }
        }
        
    }
}
