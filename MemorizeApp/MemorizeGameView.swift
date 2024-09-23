//
//  MemorizeGameView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct MemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        return VStack {
            Text("Memorize!").bold().font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding(10)
    }
    
    var cards: some View {
        return LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 75), spacing: 0)],
            spacing: 0) {
                ForEach(viewModel.cards) {card in
                    if !card.isMatched {
                        CardView(card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .padding(5)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
            }
            .foregroundColor(.accentColor)
        }
    }
    
    func shuffle() {
        viewModel.shuffle()
    }
    
    
}



struct CardView: View {
    let card: MemorizeGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
}





#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
