//
//  ContentView.swift
//  LingoLock
//
//  Created by Max on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var word: String
    var definition: String

    var body: some View {
        VStack(spacing: 10) {
            Text(word)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(definition)
                .font(.body)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color(.sRGB, red: 176/255, green: 76/255, blue: 68/255, opacity: 1))
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(word: "Parola", definition: "A word in Italian")
            .previewLayout(.sizeThatFits)
    }
}

