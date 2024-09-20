//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: [Card]
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
