//
//  MainViewModel.swift
//  SyncZone
//
//  Created by YL He on 7/1/24.
//
import FirebaseAuth
import Foundation


class MainViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    //listener for authentication state changes
    @Published var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener{[weak self]_, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
