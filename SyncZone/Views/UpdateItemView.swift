//
//  UpdateItemVIew.swift
//  SyncZone
//
//  Created by YL He on 7/3/24.
//

import SwiftUI

struct UpdateItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var item: SyncZoneListItem
    @ObservedObject var viewModel: SyncZoneViewModel

    var body: some View {
        VStack {
            Text("Edit Group")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 10)

            Form {
                Section(header: Text("Group Name")) {
                    TextField("Enter Group Name", text: $item.listName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 10)
                }

                Section(header: Text("Enter City Name")) {
                    TextField("Enter a city name...", text: $viewModel.city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 10)

                    ForEach(viewModel.autocompleteCities, id: \.self) { city in
                        Button(action: {
                            viewModel.addCity(to: $item, city: city)
                        }) {
                            Text(city)
                                .foregroundColor(.blue)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.horizontal)
                }

                Section(header: Text("Selected Cities")) {
                    ForEach($item.selectedCities, id: \.self) { $city in
                        HStack {
                            Text(city)
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(5)

                            Spacer()

                            Button(action: {
                                viewModel.deleteCity(from: $item, city: city)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            item.selectedCities.remove(at: index)
                        }
                    }
                    .padding(.horizontal)
                }

                Section(header: Text("Preferred Meeting Time")) {
                    HStack {
                        Text("From")
                        DatePicker("", selection: $item.startTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()

                        Text("To")
                        DatePicker("", selection: $item.endTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(CompactDatePickerStyle())
                            .labelsHidden()
                    }
                    .padding(.horizontal)
                }
            }

            Button(action: {
                viewModel.update(item: item)
                viewModel.showingEditItemView = false
            }) {
                Text("Update")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color("colorPrimary"))
                    .cornerRadius(10)
                    .padding(.top, 10)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text(viewModel.alertMsg))
            }
            .padding()
        }
    }
}

#Preview {
    UpdateItemView(item: .constant(SyncZoneListItem(id: "", listName: "", selectedCities: [], startTime: Date(), endTime: Date(), createdDate: Date().timeIntervalSince1970)), viewModel: SyncZoneViewModel(userId: "sampleUserId"))
    
}
