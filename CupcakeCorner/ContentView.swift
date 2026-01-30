//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta Enriquez on 30/01/26.
//

import SwiftUI

struct ContentView: View {
    @State private var username = ""
    @State private var email = ""
    
    var disabledForm: Bool {
        username.isEmpty || username.count < 3 || email.isEmpty
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Button("Create Account") {
                print("Creating Account...")
            }
            .disabled(disabledForm)
        }
    }
}

#Preview {
    ContentView()
}
