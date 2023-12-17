//
//  SupaDooApp.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 14/11/23.
//

import SwiftUI

@main
struct SupaDooApp: App {
    @StateObject private var supaDooViewModel = SupaDooViewModel()
    
    var body: some Scene {
        WindowGroup {
            if supaDooViewModel.isAuthenticated {
                HomeView(supaDooViewModel: supaDooViewModel)
                    .onAppear {
                        Task {
                            try await supaDooViewModel.fetchTodoItems()
                        }
                    }
            } else {
                WelcomeView(supaDooViewModel: supaDooViewModel)
            }
        }
    }
}
