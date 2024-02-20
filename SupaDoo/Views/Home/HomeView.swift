//
//  HomeView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 14/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showAddNewItem = false
    @State private var showDeleteItemAlert = false
    
    @StateObject var supaDooViewModel = SupaDooViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(supaDooViewModel.shoppings) { todoItem in
                    NavigationLink {
                        DetailView(todoItem: todoItem)
                    } label: {
                        Text(todoItem.name)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            showDeleteItemAlert.toggle()
                        } label: {
                            Label("Rimuovi", systemImage: "trash.fill")
                        }
                    }
                    .alert("Sei sicuro di rimuovere questo elemento?", isPresented: $showDeleteItemAlert) {
                        Button(role: .destructive) {
                            Task {
                                if let id = todoItem.id {
                                    try await supaDooViewModel.deleteTodoItem(at: id)
                                }
                            }
                        } label: {
                            Text("Rimuovi")
                        }
                        
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("Annulla")
                        }
                    }
                }
            }
            .task {
                try? await supaDooViewModel.fetchTodoItems()
                await supaDooViewModel.isUserAuthenticated()
            }
            .navigationTitle("SupaDoo")
            .navigationDestination(for: Shoppings.self) { todoItem in
                DetailView(todoItem: todoItem)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddNewItem = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundStyle(Color.blue)
                    })
                    .sheet(isPresented: $showAddNewItem) {
                        OperationView(supaDooViewModel: supaDooViewModel, shoppingItem: nil)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(supaDooViewModel: .init())
}
