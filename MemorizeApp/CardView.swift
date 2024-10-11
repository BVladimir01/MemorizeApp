//
//  CardView.swift
//  MemorizeApp
//
//  Created by Vladimir on 26.09.2024.
//

import SwiftUI

struct CardView: View {
    
    typealias StringGame = MemorizeGame<String>
    typealias Card = StringGame.Card
    
    let card: Card
    
    var body: some View {
        Text(card.content)
        .font(.system(size: Constants.textFontSize))
        .minimumScaleFactor(Constants.minScaleFactor)
        .aspectRatio(1, contentMode: .fit)
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
    }
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let textFontSize = CGFloat(200)
        static let minScaleFactor = CGFloat(0.01)
        static let pieOpacity = 0.6
    }
}

#Preview {
    CardView(MemorizeGame.Card(isFaceUp: true, isMatched: false, alreadySeen: false, content: "⚽️", id: "X"))
        .padding(20)
        .foregroundColor(.red)
}
