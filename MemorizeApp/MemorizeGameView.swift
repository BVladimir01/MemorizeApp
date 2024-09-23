//
//  MemorizeGameView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct MemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let aspectRatio: CGFloat = 2/3
    var body: some View {
        return VStack {
            Text("Memorize \(viewModel.themeId)! \(viewModel.score)").bold().font(.largeTitle)
            cards.animation(.default, value: viewModel.cards)
            Button("NewGame") {
                viewModel.newGame()
            }
            .font(.largeTitle)
            .foregroundColor(Color(fromString: viewModel.theme.color))
        }
        .padding(10)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) {card in
            CardView(card)
                .padding(5)
                .onTapGesture { viewModel.choose(card) }
        }
        .foregroundColor(Color(fromString: viewModel.theme.color))
    }
}



struct CardView: View {
    let card: MemorizeGameModel<String>.MemorizeGame<String>.Card
    
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
    
    init(_ card: MemorizeGameModel<String>.MemorizeGame<String>.Card) {
        self.card = card
    }
}





#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
