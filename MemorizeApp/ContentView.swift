//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["😀", "😁", "😅", "😥"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) {index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding(10)
    }
}



struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 10)
                Text(content).font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
//            print("lmao")
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}
