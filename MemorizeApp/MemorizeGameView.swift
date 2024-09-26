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
            Text("Memorize \(viewModel.themeId)! \(viewModel.score)").bold().font(.largeTitle)
            cards.animation(.default, value: viewModel.cards)
            Button("NewGame") {
                viewModel.newGame()
            }
            .font(.largeTitle)
            .foregroundColor(Color(fromString: viewModel.theme.color))
        }
        .padding(Constants.mainPadding)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 2 / 3) {card in
            CardView(card)
                .padding(Constants.cardPadding)
                .onTapGesture { viewModel.choose(card) }
        }
        .foregroundColor(Color(fromString: viewModel.theme.color))
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
