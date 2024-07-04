import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel = NewItemViewModel()
    //@Binding var item: SyncZoneListItem
    @Binding var newItemPresented: Bool
    
    var body: some View {
            VStack {
                Text("Create New Group")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 10)
                
                Form {
                    Section(header: Text("Group Name")) {
                        TextField("Enter Group Name", text: $viewModel.listName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 10)
                    }
                    
                    Section(header: Text("Enter City Name")) {
                        TextField("Enter a city name...", text: $viewModel.city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 10)
                        
                        ForEach(viewModel.autocompleteCities, id: \.self) { city in
                            Button(action: {
                                if viewModel.canAdd {
                                    viewModel.addCity(city)
                                } else {
                                    viewModel.showAlert = true
                                }
                            }) {
                                Text(city)
                                    .foregroundColor(.blue)
                                    .padding(.vertical, 8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Section(header: Text("Selected Cities")) {
                        ForEach(viewModel.selectedCities, id: \.self) { city in
                            HStack {
                                Text(city)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(5)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.deleteCity(city)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .padding(.trailing, 8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Section(header: Text("Preferred Meeting Time")) {
                        HStack {
                            Text("From")
                            DatePicker("", selection: $viewModel.startTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                            
                            Text("To")
                            DatePicker("", selection: $viewModel.endTime, displayedComponents: .hourAndMinute)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                        }
                        .padding(.horizontal)
                    }
                }
                
                Button(action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
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
    NewItemView(newItemPresented: Binding(get: {
        return true
    }, set: { _ in
        
    }))
//    NewItemView(item: .constant(SyncZoneListItem(id: "", listName: "", selectedCities: [], startTime: Date(), endTime: Date(), createdDate: Date().timeIntervalSince1970)), newItemPresented: Binding(get: {
//           return true
//       }, set: { _ in
//           
//       }))
}
