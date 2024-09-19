//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojiTheme: EmojiTheme = .faces
    @State var cardCount = 0
    var emojis: [String] {
        emojiOptions[emojiTheme]!
    }
    
    var body: some View {
        VStack {
            Text("Memorize!").bold().font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountControls
        }
        .padding(10)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundColor(.accentColor)
        }
    }
    
    var cardCountControls: some View {
        HStack {
            cardRemover
            Spacer()
            emojiThemeControls
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.title)
    }
    
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 0 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    func emojiThemeSetter(to theme: EmojiTheme) -> some View {
        Button(action: {
            emojiTheme = theme
        }, label: {
            VStack {
                Text(theme.rawValue)
                themeIcons[theme]
            }
        })
    }
    
    var emojiThemeControls: some View {
        HStack {
            emojiThemeSetter(to: .faces)
            emojiThemeSetter(to: .balls)
            emojiThemeSetter(to: .animals)
        }
    }
    enum EmojiTheme: String {
        case faces, balls, animals
    }
    
    var emojiOptions: [EmojiTheme: [String]] = [
        .faces: ["😀", "🤣", "😌", "😛", "🥸", "😩", "🤯"],
        .balls: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"],
        .animals: ["🐶", "🐱", "🐭", "🐹", "🦊", "🐻", "🦁"]
    ]
    
    var themeIcons: [EmojiTheme: Image] = [
        .faces: Image(systemName: "face.smiling.fill"),
        .animals: Image(systemName: "pawprint.fill"),
        .balls: Image(systemName: "basketball.fill")
    ]
}



struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}





#Preview {
    ContentView()
}
