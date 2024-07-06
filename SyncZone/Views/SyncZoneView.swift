//
//  SyncGroupView.swift
//  SyncZone
//
//  Created by YL He on 6/30/24.
//

import FirebaseFirestoreSwift
import SwiftUI

struct SyncZoneView: View {
    @StateObject var viewModel: SyncZoneViewModel
    @FirestoreQuery var items: [SyncZoneListItem]
    @State private var searchText = ""
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/syncLists")
        self._viewModel = StateObject(wrappedValue: SyncZoneViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText, placeholder: "Search...")
                
                if items.isEmpty {
                    Text("No items available.")
                        .padding()
                } else {
                    List {
                        ForEach(items.filter { item in
                            searchText.isEmpty ||
                            item.listName.localizedCaseInsensitiveContains(searchText) ||
                            item.selectedCities.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
                        }) { item in
                            HStack {
                                SyncZoneListItemView(item: item)
                                    .onTapGesture {
                                        viewModel.itemToEdit = item
                                        viewModel.showingEditItemView = true
                                    }
                                    .swipeActions {
                                        Button {
                                            viewModel.delete(id: item.id)
                                        } label: {
                                            Text("Delete")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .padding(.trailing, 20)
                                    .buttonStyle(BorderlessButtonStyle())
                                
                                Button(action: {
                                    viewModel.selectedItem = item
                                    viewModel.showingItemView = true
                                }) {
                                    Text("View")
                                        .foregroundColor(Color("colorPrimary"))
                                }
                            }
                            
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .navigationBarTitle("Sync Zone")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color("colorPrimary"))
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingEditItemView) {
                if let itemToEdit = viewModel.itemToEdit {
                    UpdateItemView(item: Binding(get: {
                        itemToEdit
                    }, set: { newValue in
                        viewModel.itemToEdit = newValue
                    }), viewModel: viewModel)
                }
            }
            .sheet(isPresented: $viewModel.showingItemView) {
                if let selectedItem = viewModel.selectedItem {
                    ItemViewView(item: Binding(get: {
                        selectedItem
                    }, set: { newValue in
                        viewModel.selectedItem = newValue
                    }), viewModel: ItemViewViewModel(), showingItemView: $viewModel.showingItemView)
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView)
            }
        }
    }
}

#Preview {
    SyncZoneView(userId: "q0tDK4VvBHOOjL1i24iGgJ04JCF2")
}
