//
//  HomeView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 14/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showAddNewItem = false
    
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
