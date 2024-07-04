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

    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/syncLists")
        self._viewModel = StateObject(wrappedValue: SyncZoneViewModel(userId: userId))
    }

    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    Text("No items available.")
                } else {
                    List {
                        ForEach(items) { item in
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
                                                                
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Sync Zone")
            .sheet(isPresented: $viewModel.showingEditItemView) {
                if let itemToEdit = viewModel.itemToEdit {
                    UpdateItemView(item: Binding(get: {
                        itemToEdit
                    }, set: { newValue in
                        viewModel.itemToEdit = newValue
                    }), viewModel: viewModel)
                }
            }


            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        //action
//                    } label: {
//                        Text("Edit")
//                    }
//                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showingNewItemView = true
                    } label: {
                        Image(systemName: "plus")
                    }
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
