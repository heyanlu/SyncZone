//
//  ItemViewView.swift
//  SyncZone
//
//  Created by YL He on 7/4/24.
//
import SwiftUI
import CoreLocation

struct ItemViewView: View {
    @Binding var item: SyncZoneListItem
    @ObservedObject var viewModel: ItemViewViewModel
    @ObservedObject var locationManager = LocationManager.shared
    @Binding var showingItemView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    showingItemView = false
                } label: {
                    Text("Back")
                        .bold()
                }
                .padding(.top, 20)
                
                Text("List Information")
                    .font(.system(size: 32))
                    .bold()
            }
            .padding(.bottom, 20)
            .background(
                Circle()
                    .foregroundColor(Color("colorPrimary"))
                    .frame(width: 550, height: 550)
                    .ignoresSafeArea()
            )
            .foregroundColor(.white)

            // Group Information
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar.badge.clock")
                        .font(.title)
                        .foregroundColor(Color("colorPrimary"))
                    VStack(alignment: .leading) {
                        Text("Selected Cities: \(item.selectedCities.joined(separator: ", "))")
                            .font(.body)
                        HStack {
                            Text("Preferred From: \(viewModel.formattedDate(item.startTime))")
                            Text("To: \(viewModel.formattedDate(item.endTime))")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(radius: 2)
                )
                .padding(.bottom, 10)
            }
            
            // Current Time For Cities
            VStack(alignment: .leading) {
                Text("Current Time For Cities:")
                    .font(.headline)
                    .padding(.top, 10)
                    .foregroundColor(Color("colorPrimary"))
                
                ForEach(item.selectedCities, id: \.self) { city in
                    HStack {
                        Text(city)
                            .padding(.leading, 10)
                        Spacer()
                        Text(viewModel.localTime(for: city) ?? "Time unavailable")
                            .foregroundColor(viewModel.localTime(for: city) != nil ? .black : .red)
                    }
                    .padding(.vertical, 8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 2)
                    .padding(.bottom, 20)

            )
            
            // Suggested Chatting Time
            VStack(alignment: .leading) {
                Text("Overlapping Time With Your Location:")
                    .font(.headline)
                    .padding(.top, 10)
                    .foregroundColor(Color("colorPrimary"))

                
                if let placemark = locationManager.placemark, let currentCity = placemark.locality {
                    ForEach(item.selectedCities, id: \.self) { city in
                        if let overlapTime = viewModel.calculateOverlap(
                            start1: item.startTime,
                            end1: item.endTime,
                            city1: currentCity,
                            start2: item.startTime,
                            end2: item.endTime,
                            city2: city
                        ) {
                            Text("\(city): \(overlapTime)")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)

                        } else {
                            Text("\(city): No overlap time")
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                } else {
                    Text("Waiting for location...")
                        .padding(.vertical, 8)
                        .onAppear {
                            locationManager.requestLocation()
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ItemViewView(item: .constant(SyncZoneListItem(id: "1", listName: "Sample List", selectedCities: ["New York, US", "London, UK"], startTime: Date(), endTime: Date(), createdDate: Date().timeIntervalSince1970)), viewModel: ItemViewViewModel(), showingItemView: .constant(true))
}
