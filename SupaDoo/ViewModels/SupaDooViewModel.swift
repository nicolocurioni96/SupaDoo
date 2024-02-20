//
//  SupaDooViewModel.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 15/11/23.
//

import SwiftUI
import Supabase

enum Table {
    static let shoppings = "Shoppings"
}

@MainActor
final class SupaDooViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var shoppings = [Shoppings]()
    @Published var email = ""
    @Published var password = ""
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)
    
    // MARK: - Authentication
    func signUp() async throws {
        // TODO: Add stuff here...
        _ = try await supabase.auth.signUp(email: email, password: password)
        
        isAuthenticated = true
    }
    
    func signIn() async throws {
        // TODO: Add stuff here...
        _ = try await supabase.auth.signIn(email: email, password: password)
        
        isAuthenticated = true
    }
    
    func isUserAuthenticated() async {
        // TODO: Add stuff here...
        do {
            _ = try await supabase.auth.session.user
            isAuthenticated = true
        } catch {
            print("🔴 Error: \(error.localizedDescription)")
            
            isAuthenticated = false
        }
    }
    
    func signOut() async throws {
        // TODO: Add stuff here...
        try await supabase.auth.signOut()
        
        isAuthenticated = false
    }
    
    // MARK: - Database
    func createTodoItem(name: String) async throws {
        let user = try await supabase.auth.session.user
        let todoItem = Shoppings(createdAt: Date(), name: name, isComplete: false, userID: user.id)
        
        try await supabase
            .database
            .from(Table.shoppings)
            .insert(values: todoItem)
            .execute()
    }
    
    func fetchTodoItems() async throws {
        let shoppings: [Shoppings] = try await supabase
            .database
            .from(Table.shoppings)
            .select()
            .order(column: "created_at", ascending: false)
            .execute()
            .value
        
        DispatchQueue.main.async {
            self.shoppings = shoppings
        }
    }
    
    func update(_ shopping: Shoppings, with name: String, withStatus isComplete: Bool) async {
        guard let id = shopping.id else {
            print("🔴 Error: Can't update shopping item with id: \(String(describing: shopping.id))")
            return
        }
        
        var itemToUpdate = shopping
        
        itemToUpdate.name = name
        itemToUpdate.isComplete = isComplete
        
        do {
            try await supabase
                .database
                .from(Table.shoppings)
                .update(values: itemToUpdate)
                .eq(column: "id", value: id)
                .execute()
        } catch {
            print("🔴 Error: \(error.localizedDescription)")
        }
    }
    
    func deleteTodoItem(at id: Int) async throws {
        try await supabase
            .database
            .from(Table.shoppings)
            .delete()
            .eq(column: "id", value: id)
            .execute()
        
        try? await fetchTodoItems()
    }
}
