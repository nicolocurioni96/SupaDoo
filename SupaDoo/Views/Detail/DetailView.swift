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
            }
        }
    }
}

#Preview {
    DetailView(todoItem: .init(createdAt: Date(), name: "Cake", isComplete: false, userID: UUID()))
}
