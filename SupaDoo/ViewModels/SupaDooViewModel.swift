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
        // TODO: Add stuff here...
    }
    
    func fetchTodoItems() async throws {
        // TODO: Add stuff here...
    }
    
    func update(_ shopping: Shoppings, with name: String) async {
        // TODO: Add stuff here...
    }
    
    func update(_ shopping: Shoppings, withStatus isCompleted: Bool) async {
        // TODO: Add stuff here...
    }
    
    func deleteFeature(at id: Int) async throws {
        // TODO: Add stuff here...
    }
}
