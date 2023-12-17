//
//  HomeView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 14/11/23.
//

import SwiftUI

struct HomeView: View {
    @State private var showAddNewItem = false
    
    @ObservedObject var supaDooViewModel: SupaDooViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(supaDooViewModel.shoppings, id: \.self) { todoItem in
                        NavigationLink {
                            DetailView(todoItem: todoItem)
                        } label: {
                            Text(todoItem.name)
                        }
                    }
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
                            AddItemView(supaDooViewModel: supaDooViewModel)
                        }
                    }
                }
            }
        }
        .task {
            await supaDooViewModel.isUserAuthenticated()
        }
    }
}

#Preview {
    HomeView(supaDooViewModel: .init())
}
