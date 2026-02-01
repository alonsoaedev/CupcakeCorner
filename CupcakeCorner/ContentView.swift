//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta Enriquez on 30/01/26.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name: String = "Taylor"
}

struct ContentView: View {
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    var body: some View {
        Button("Encode taylor", action: encodeTaylor)
    }
}

#Preview {
    ContentView()
}
