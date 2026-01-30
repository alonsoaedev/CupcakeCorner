//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Alonso Acosta Enriquez on 30/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // this one won't apply the frame because SwiftUI won't know how big the image will be
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 4)
//            .frame(width: 200, height: 200)
        
        // this one will apply the frame beacause SwiftUI (after the loading) will know how big the image will be
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 4) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            // Display this while waiting for the image
            ProgressView()
        }
        .frame(width: 200, height: 200)
        
        // this one will apply the frame beacause SwiftUI (after the loading) will know how big the image will be
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 4) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ContentView()
}
