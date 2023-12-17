//
//  WelcomeView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 17/11/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var loginSheet = false
    @State private var registerSheet = false
    
    @ObservedObject var supaDooViewModel: SupaDooViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Welcome to SupaDoo")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .hoverEffect()
                
                Spacer()
            }
            .padding(18)
            
            Spacer()
            
            VStack {
                Button {
                    loginSheet = true
                } label: {
                    Text("Sign In")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Rectangle())
                .cornerRadius(10)
                .sheet(isPresented: $loginSheet) { LoginView(supaDooViewModel: supaDooViewModel) }
                
                Button {
                    registerSheet = true
                } label: {
                    Text("Sign Up")
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                .background(
                    RoundedRectangle(
                        cornerRadius: 10,
                        style: .continuous
                    ).stroke(Color.blue))
                .foregroundColor(Color.blue)
                .clipShape(Rectangle())
                .cornerRadius(10)
                .sheet(isPresented: $registerSheet) { RegisterView(supaDooViewModel: supaDooViewModel) }
            }
            .padding(18)
        }
        .task {
            await supaDooViewModel.isUserAuthenticated()
        }
    }
}

#Preview {
    WelcomeView(supaDooViewModel: .init())
}
