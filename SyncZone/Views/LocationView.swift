//
//  SwiftUIView.swift
//  SyncZone
//
//  Created by YL He on 6/29/24.
//
import MapKit
import SwiftUI


struct LocationView: View {
    @ObservedObject var locationManager = LocationManager.shared
    @State private var locationDescription: String = "Location: Not available"
    
    var body: some View {
        Group {
            if let userLocation = locationManager.userLocation {
                VStack {
                    Text(locationDescription)
                        .padding()
                        .onAppear {
                            locationManager.getPlace(for: userLocation) { placemark in
                                guard let placemark = placemark else { return }

                                var output = "Location: "
                                if let town = placemark.locality {
                                    output += "\(town), "
                                }
                                if let state = placemark.administrativeArea {
                                    output += "\(state), "
                                }
                                if let country = placemark.country {
                                    output += "\(country)"
                                }
                                
                                let currentTime = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "HH:mm:ss"
                                let timeString = formatter.string(from: currentTime)
                                
                                output += "\nCurrent Time: \(timeString)"
                                locationDescription = output
                            }
                        }
                    
                }
            } else {
                LocationRequestView()
            }
        }
    }
}

#Preview {
    LocationView()
}
