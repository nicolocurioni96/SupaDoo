//
//  DetailView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 17/11/23.
//

import SwiftUI

struct DetailView: View {
    let todoItem: Shoppings
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var supaDooViewModel = SupaDooViewModel()
    
    @State private var editShoppingItem = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Section {
                        Text(todoItem.name)
                            .font(.headline)
                            .fontWeight(.medium)
                    }
                    
                    Section {
                        Text(DateFormatter.localizedString(from: todoItem.createdAt, dateStyle: .medium, timeStyle: .medium))
                            .font(.headline)
                            .fontWeight(.medium)
                    }
                }
                .navigationTitle(todoItem.name)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            editShoppingItem = true
                        }, label: {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title2)
                                .fontWeight(.black)
                                .foregroundStyle(Color.blue)
                        })
                        .sheet(isPresented: $editShoppingItem) {
                            OperationView(supaDooViewModel: .init(), shoppingItem: todoItem)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(todoItem: .init(createdAt: Date(), name: "Cake", isComplete: false, userID: UUID()))
}
