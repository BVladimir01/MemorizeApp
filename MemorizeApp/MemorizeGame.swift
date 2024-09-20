//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFacotory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(numberOfPairsOfCards, 2) {
            let content = cardContentFacotory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
