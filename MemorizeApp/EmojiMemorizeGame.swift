//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    private static let emojis = ["😀", "🤣", "😌", "😛", "🥸", "🤯"]
    
    private static func createMemorizeGame() -> MemorizeGame<String> {
        MemorizeGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                emojis[pairIndex]
            } else {
                "⁉️"
            }
        }
    }
    
    @Published private var model = EmojiMemorizeGame.createMemorizeGame()
    
    var cards: [MemorizeGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    
}
