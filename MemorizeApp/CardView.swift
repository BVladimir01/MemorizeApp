//
//  CardView.swift
//  MemorizeApp
//
//  Created by Vladimir on 26.09.2024.
//

import SwiftUI

struct CardView: View {
    let card: MemorizeGameModel<String>.MemorizeGame<String>.Card
    
    var body: some View {
        Text(card.content).cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
    }
    
    init(_ card: MemorizeGameModel<String>.MemorizeGame<String>.Card) {
        self.card = card
    }
    
    private struct Constants {
        static let textFontSize = CGFloat(200)
        static let borderWidth = CGFloat(3)
        static let minScaleFactor = CGFloat(0.01)
        static let cornerRadius = CGFloat(10)
    }
}

#Preview {
    CardView(MemorizeGameModel.MemorizeGame.Card(isFaceUp: true, isMatched: false, alreadySeen: false, content: "X", id: "X"))
        .padding(20)
        .foregroundColor(.red)
}
