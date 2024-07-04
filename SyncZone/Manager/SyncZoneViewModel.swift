//
//  SyncZoneViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import Combine
import SwiftUI


class SyncZoneViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingEditItemView = false
    
    @Published var listName = ""
    @Published var city = ""
    @Published var startTime = Date()
    @Published var endTime = Date()
    
    @Published var selectedCities: [String] = []
    @Published var autocompleteCities: [String] = []
    
    @Published var selectedItem: SyncZoneListItem?
    @Published var items: [SyncZoneListItem] = []
    @Published var itemToEdit: SyncZoneListItem?
    
    @Published var showAlert: Bool = false
    @Published var alertMsg: String = ""
    
    
    let allCities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]

    private var cancellables: Set<AnyCancellable> = []

    private let userId: String
    
    init(userId: String) {
        self.userId = userId
        $city
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard !searchText.isEmpty else {
                    self?.autocompleteCities = []
                    return
                }
                self?.autocompleteCities = self?.allCities.filter { $0.lowercased().contains(searchText.lowercased()) } ?? []
            }
            .store(in: &cancellables)
    }
    
    
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("syncLists")
            .document(id)
            .delete()
    }
    
    
    func update(item: SyncZoneListItem) {
        let db = Firestore.firestore()
        do {
            try db.collection("users").document(userId).collection("syncLists").document(item.id).setData(from: item) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document successfully updated")
                }
            }
        } catch let error {
            print("Error writing item to Firestore: \(error)")
        }
    }
    

    func save() {
        guard canSave else { return }

        //get userid
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }


        //create data model
        let newId = UUID().uuidString
        let newList = SyncZoneListItem(
            id: newId,
            listName: listName,
            selectedCities: selectedCities,
            startTime: startTime,
            endTime: endTime,
            createdDate: Date().timeIntervalSince1970
        )


        //save
        let db = Firestore.firestore()

        do {
            try db.collection("users")
                .document(userId)
                .collection("syncLists")
                .document(newId)
                .setData(from: newList) { error in
                    if let error = error {
                        print("Error writing document: \(error)")
                    } else {
                        print("Document successfully written!")
                    }
                }
        } catch let error {
            print("Error writing document: \(error)")
        }


        selectedCities.append(city)
        city = ""
        selectedCities.removeAll()
    }

    var canSave: Bool {
        guard !listName.trimmingCharacters(in: .whitespaces).isEmpty || selectedCities.count > 0 else {
            showAlert(title: "Please fill in all fields and select due date.")
            return false
        }

        guard startTime < endTime else {
            showAlert(title: "Start time cannot be later than end time.")
            return false
        }
        return true
    }

    var canAdd: Bool {
        let maxCities = 5
        let normalizedCity = city.lowercased()

        guard selectedCities.count < maxCities else {
            showAlert(title: "Reached the maximum number of cities in one group.")
            return false
        }

        guard !selectedCities.map({ $0.lowercased() }).contains(normalizedCity) else {
            showAlert(title: "city already selected.")
            return false
        }

        return true
    }
    
    func addCity(to item: Binding<SyncZoneListItem>, city: String) {
        if !item.wrappedValue.selectedCities.contains(city) {
            item.wrappedValue.selectedCities.append(city)
        } else {
            alertMsg = "City is already added."
            showAlert = true
        }
    }
    
    func deleteCity(from item: Binding<SyncZoneListItem>, city: String) {
        if let index = item.wrappedValue.selectedCities.firstIndex(of: city) {
            item.wrappedValue.selectedCities.remove(at: index)
        } else {
            alertMsg = "City not found."
            showAlert = true
        }
    }


    func showAlert(title: String) {
        alertMsg = title
        showAlert = true
    }
    
}
