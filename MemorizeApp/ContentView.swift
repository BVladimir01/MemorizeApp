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
        .foregroundColor(.orange)
        .padding(10)
    }
}



struct CardView: View {
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 10)
                Text("😁").font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            print("lmao")
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}
