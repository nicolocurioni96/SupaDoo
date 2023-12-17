//
//  AddItemView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 17/11/23.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var supaDooViewModel: SupaDooViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var isComplete = false
    
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
                            saveItem()
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
        }
    }
    
    // MARK: - Private methods
    private func saveItem() {
        Task {
            try await supaDooViewModel.createTodoItem(name: name)
            try await supaDooViewModel.fetchTodoItems()
        }
    }
}

#Preview {
    AddItemView(supaDooViewModel: .init())
}
