//
//  OperationView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 17/11/23.
//

import SwiftUI

struct OperationView: View {
    @ObservedObject var supaDooViewModel: SupaDooViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var isComplete = false
    
    let shoppingItem: Shoppings?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $name) {
                    Text("Item name")
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        withAnimation {
                            operationItem()
                            dismiss()
                        }
                    } label: {
                        Text("Save")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(name.isEmpty)
                }
            }
            .onAppear {
                if let shoppingItem {
                    // Edit TODO item..
                    name = shoppingItem.name
                    isComplete = shoppingItem.isComplete
                } else {
                    // Add new TODO item..
                }
            }
        }
    }
    
    // MARK: - Private methods
    private func operationItem() {
        Task {
            if let shoppingItem {
                // Edit TODO item..
                await supaDooViewModel.update(shoppingItem, with: name, withStatus: isComplete)
                try await supaDooViewModel.fetchTodoItems()
            } else {
                // Add new TODO item..
                try await supaDooViewModel.createTodoItem(name: name)
                try await supaDooViewModel.fetchTodoItems()
            }
        }
    }
}

#Preview {
    OperationView(supaDooViewModel: .init(), shoppingItem: nil)
}
