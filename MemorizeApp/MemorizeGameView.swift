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
        Button("NewGame") {
            withAnimation {
                viewModel.newGame()
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
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(Color(fromString: viewModel.theme.color))
    }
    
    private func ScoreChange(causedBy card: Card) -> Int {
        return 0
    }
    
    private struct Constants {
        static let cardPadding = CGFloat(5)
        static let mainPadding = CGFloat(10)
        static let aspectRatio = CGFloat(2 / 3)
    }
}





#Preview {
    MemorizeGameView(viewModel: EmojiMemorizeGame())
}
