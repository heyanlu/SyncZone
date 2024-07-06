//
//  NewItemViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation
import Combine 



class NewItemViewModel: ObservableObject {
    @Published var listName = ""
    @Published var city = ""
    @Published var startTime = Date()
    @Published var endTime = Date()
    
    @Published var selectedCities: [String] = []
    @Published var autocompleteCities: [String] = []

    @Published var alertMsg: String = ""
    @Published var showAlert: Bool = false
    
    let allCities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
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
    
//    private func fetchAutocompleteCities(for searchText: String) {
//        fetchCities { [weak self] cities in
//            DispatchQueue.main.async {
//                self?.autocompleteCities = cities?.filter {
//                    $0.lowercased().contains(searchText.lowercased())
//                } ?? []
//            }
//        }
//    }
    
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
    
    func addCity(_ city: String) {
        print("city to be added: ", city)

        let normalizedCity = city.lowercased()
        guard !selectedCities.map({ $0.lowercased() }).contains(normalizedCity) else {
            showAlert(title: "City already selected.")
            return
        }
        selectedCities.append(city)
        autocompleteCities = []
        self.city = ""
    }
    
    
    func deleteCity(_ city: String) {
        print("city to be delete: ", city)

        if let index = selectedCities.firstIndex(of: city) {
            selectedCities.remove(at: index)
        }
        print("city index: ", index)
    }
    
    func delete(indexSet: IndexSet) {
        let indicesToDelete = Array(indexSet)
        
        for index in indicesToDelete.sorted(by: >) {
            selectedCities.remove(at: index)
        }
    }

    
    
    func showAlert(title: String) {
        alertMsg = title
        showAlert = true
    }
}

