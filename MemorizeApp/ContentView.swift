//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView(isFaceUp: true)
        }
    }
}



struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        if isFaceUp {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: 10)
                Text("😁").font(.largeTitle)
            }
            .foregroundColor(.orange)
            .padding(10)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            }
            .foregroundColor(.orange)
            .padding(10)
        }
    }
}
    
#Preview {
    ContentView()
}
