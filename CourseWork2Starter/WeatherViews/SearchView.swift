//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 11/03/2023.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var isSearchOpen: Bool
    @State var location = ""
    @Binding var userLocation: String
    
    var isValidated: Bool {!location.isEmpty}
    
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                     
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in

                        
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {

                            Task {
                                let _ = try await modelData.loadData(lat: lat, lon: lon)
                                userLocation = location
                                modelData.userLocation = location
                            }
                            
                            isSearchOpen.toggle()
                        }
                        
                        
                    }//GEOCorder
                } //Commit
                          
                )// TextField
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15) // TextField
                
            }//VStak
            
            
        }// Zstack
    }// Some
    
} //View
