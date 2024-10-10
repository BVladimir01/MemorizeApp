//
//  MemorizeGameView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct MemorizeGameView: View {
    
    typealias StringGameModel = MemorizeGameModel<String>
    typealias StringGame = StringGameModel.MemorizeGame<String>
    typealias Card = StringGame.Card
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        return VStack {
            title
            cards
            controls
        }
        .padding(Constants.mainPadding)
    }
    
    private var title: some View {
        Text("Memorize \(viewModel.themeId)! \(viewModel.score)")
            .bold()
            .font(.largeTitle)
            .animation(nil)
    }
    
    private var controls: some View {
        HStack {
            Spacer()
            Button("NewGame") {
                withAnimation {
                    viewModel.newGame()
                }
            }
        }
        .font(.largeTitle)
        .foregroundColor(Color(fromString: viewModel.theme.color))
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 2 / 3) {card in
            CardView(card)
                .padding(Constants.cardPadding)
                .overlay(FlyingNumber(number: ScoreChange(causedBy: card)))
                .zIndex(ScoreChange(causedBy: card) != 0 ? 1 : 0)
                .onTapGesture {
                    choose(card)
                }
        }
        .foregroundColor(Color(fromString: viewModel.theme.color))
    }

    private func choose (_ card: Card) {
        withAnimation(.easeInOut) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChage = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChage, card.id)
            
            if viewModel.gameHasEnded {
                viewModel.newGame()
            }
        }
    }
    
    @State private var lastScoreChange: (Int, causedByCardId: Card.ID) = (0, causedByCardId: "")
    
    
    private func ScoreChange(causedBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
    }
    
    private struct Constants {
        static let cardPadding = CGFloat(5)
        static let mainPadding = CGFloat(10)
        static let aspectRatio = CGFloat(2 / 3)
        static let deckWidth = CGFloat(50)
        static let dealInterval = 0.2
        static let dealDuration = 0.8
    }
}





#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
