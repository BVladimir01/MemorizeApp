//
//  MemorizeGameView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct MemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    @State var emojiTheme: EmojiTheme = .faces
    
    var body: some View {
        return VStack {
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
        return LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 75), spacing: 0)],
            spacing: 0) {
                ForEach(viewModel.cards.indices, id: \.self) {index in
                    CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
            }
            .foregroundColor(.accentColor)
        }
    }
    
    func shuffle() {
        viewModel.shuffle()
    }
    
    func emojiThemeSetter(to theme: EmojiTheme) -> some View {
        return Button(action: {
            emojiTheme = theme
        }, label: {
            VStack {
                Text(theme.rawValue).font(.title3)
                themeIcons[theme]
            }
        })
    }
    
    var emojiThemeControls: some View {
        return HStack {
            emojiThemeSetter(to: .faces)
            Spacer()
            emojiThemeSetter(to: .balls)
            Spacer()
            emojiThemeSetter(to: .animals)
            Button("shuffle"){
                viewModel.shuffle()
            }
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
    let card: MemorizeGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
    }
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
}





#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
