//
//  ContentView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojiTheme: EmojiTheme = .faces
    var cardCount: Int {
        emojis.count
    }
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
            emojiThemeControls
        }
        .padding(10)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundColor(.accentColor)
        }
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
            Spacer()
            emojiThemeSetter(to: .balls)
            Spacer()
            emojiThemeSetter(to: .animals)
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    enum EmojiTheme: String {
        case faces, balls, animals
    }
    
    let emojiOptions: [EmojiTheme: [String]] = [
        .faces: ["😀", "🤣", "😌", "😛", "🥸", "🤯"],
        .balls: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"],
        .animals: ["🐶", "🐭", "🦊", "🐻", "🦁"]
    ]
    
    let themeIcons: [EmojiTheme: Image] = [
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
