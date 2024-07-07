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

    private var cancellables: Set<AnyCancellable> = []
    private let apiKey = AppConfig.getAPIKey() ?? ""

    init() {
        $city
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard !searchText.isEmpty else {
                    self?.autocompleteCities = []
                    return
                }
                self?.fetchCitySuggestions(query: searchText)
            }
            .store(in: &cancellables)
    }

    // API
    func fetchCitySuggestions(query: String) {
        guard !query.isEmpty else {
            autocompleteCities = []
            return
        }

        let urlString = "https://api.api-ninjas.com/v1/city?name=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"

        guard let url = URL(string: urlString) else {
            print("Invalid URL:", urlString)
            return
        }

        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForResource = 30

        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching city suggestions:", error)
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let locations = try decoder.decode([Location].self, from: data)
                DispatchQueue.main.async {
                    self?.autocompleteCities = locations.map { "\($0.name)" }
                }
            } catch {
                print("Error parsing JSON:", error)
            }
        }
        task.resume()
    }

    func save() {
        guard canSave else { return }

        // Get user ID
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }

        // Create data model
        let newId = UUID().uuidString
        let newList = SyncZoneListItem(
            id: newId,
            listName: listName,
            selectedCities: selectedCities,
            startTime: startTime,
            endTime: endTime,
            createdDate: Date().timeIntervalSince1970
        )

        // Save to Firestore
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
            showAlert(title: "City already selected.")
            return false
        }

        return true
    }

    func addCity(_ city: String) {
        print("City to be added: ", city)

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
        print("City to be deleted: ", city)

        if let index = selectedCities.firstIndex(of: city) {
            selectedCities.remove(at: index)
        }
        print("City index: ", index)
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
