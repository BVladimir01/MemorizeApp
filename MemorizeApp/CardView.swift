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
        Pie(endAngle: Angle(degrees: 100))
            .opacity(Constants.pieOpacity)
            .overlay(
                Text(card.content)
                .font(.system(size: Constants.textFontSize))
                .minimumScaleFactor(Constants.minScaleFactor)
                .aspectRatio(1, contentMode: .fit)
            )
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
    }
    
    init(_ card: MemorizeGameModel<String>.MemorizeGame<String>.Card) {
        self.card = card
    }
    
    private struct Constants {
        static let textFontSize = CGFloat(200)
        static let minScaleFactor = CGFloat(0.01)
        static let pieOpacity = 0.6
    }
}

#Preview {
    CardView(MemorizeGameModel.MemorizeGame.Card(isFaceUp: true, isMatched: false, alreadySeen: false, content: "⚽️", id: "X"))
        .padding(20)
        .foregroundColor(.red)
}
