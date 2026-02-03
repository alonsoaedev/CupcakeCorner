//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta on 02/02/26.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlertMessage: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total cost is: \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showAlertMessage) {
            Button("OK") {  }
        } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //        request.httpMethod = "POST"
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedOrder)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way"
            showAlertMessage = true
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            alertTitle = "Oops!"
            alertMessage = "There was an error with your order. Please try again later."
            showAlertMessage = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
