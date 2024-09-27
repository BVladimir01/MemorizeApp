//
//  MemorizeGameView.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

struct MemorizeGameView: View {
    
    typealias Card = MemorizeGameModel<String>.MemorizeGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
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
            deck
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
            if isDealt(card) {
                CardView(card)
                    .padding(Constants.cardPadding)
                    .overlay(FlyingNumber(number: ScoreChange(causedBy: card)))
                    .zIndex(ScoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .foregroundColor(Color(fromString: viewModel.theme.color))
    }
    
    @State private var dealtCards = Set<Card.ID>()
    
    private func isDealt (_ card: Card) -> Bool {
        dealtCards.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
            .frame(width: Constants.deckWidth,
                   height: Constants.deckWidth / (2 / 3))
        }
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: Constants.dealDuration).delay(delay)) {
                _ = dealtCards.insert(card.id)
            }
            delay += Constants.dealInterval
        }
    }
    
    private func choose (_ card: Card) {
        withAnimation(.easeInOut) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChage = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChage, card.id)
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
