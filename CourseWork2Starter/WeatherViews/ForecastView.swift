//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)

                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }
            }
        }
//        .onAppear {
//            Task.init {
//                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
//
//            }
//        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
