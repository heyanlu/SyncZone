//
//  LocationManager.swift
//  SyncZone
//
//  Created by YL He on 6/29/24.
//
import CoreLocation
import Foundation


class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    
    //ensure location update
    @Published var userLocation: CLLocation? {
        didSet {
            guard let location = userLocation else { return }
            getPlace(for: location) { placemark in
                self.placemark = placemark
                self.currentTime = self.getCurrentTime(for: placemark)
                if let placemark = placemark {
                    print("DEBUG: Placemark updated - \(placemark.locality ?? "Unknown location")")
                }
            }
        }
    }
    
    
    @Published var placemark: CLPlacemark?
    @Published var currentTime: String?
    static let shared = LocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    func getPlace(for location: CLLocation,
        completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    } 
    
    
    func getCurrentTime(for placemark: CLPlacemark?) -> String? {
        guard let placemark = placemark else { return nil }
        let timeZone = placemark.timeZone ?? TimeZone.current
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
}



// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .notDetermined:
            print("DEBUG: not Determined")
        case .restricted:
            print("DEBUG: restricted")
        case .denied:
            print("DEBUG: denied")
        case .authorizedAlways:
            print("DEBUG: authorizedAlways")
        case .authorizedWhenInUse:
            print("DEBUG: authorizedWhenInUse")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.userLocation = location

    }
}


