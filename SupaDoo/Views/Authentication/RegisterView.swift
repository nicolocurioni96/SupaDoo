//
//  RegisterView.swift
//  SupaDoo
//
//  Created by Nicolò Curioni on 17/11/23.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var supaDooViewModel = SupaDooViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Text("Register")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .hoverEffect()
                    
                    Spacer()
                    
                }
                .padding(18)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.blue)
                        
                        TextField("Email", text: $supaDooViewModel.email)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Capsule()
                        .fill(Color.white))
                    .shadow(radius: 1)
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.blue)
                        
                        TextField("Password", text: $supaDooViewModel.password)
                            .autocapitalization(.none)
                    }
                    .padding()
                    .background(Capsule()
                        .fill(Color.white))
                    .shadow(radius: 1)
                    .padding(.top, 8)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button {
                        // TODO: Add stuff here...
                    } label: {
                        Text("Sign Up")
                            .font(.title2)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                }
                .padding(18)
            }
        }
    }
}

#Preview {
    RegisterView()
}
