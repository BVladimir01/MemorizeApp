//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    init(theme: Theme<String>) {
        self.theme = theme
        self.game = StringGame(theme: theme)
    }
    
    typealias StringGame = MemorizeGame<String>
    typealias Card = StringGame.Card
    
    @Published private var game: StringGame
    
    var cards: [Card] {
        return game.cards
    }
    
    var score: Int {
        game.score
    }
    
    var themeId: Theme<String>.ID {
        theme.id
    }
    
    var theme: Theme<String>
    
    var gameHasEnded: Bool {
        cards.filter( { !$0.isMatched }).count == 0
    }
    
    // MARK: - Intents
    func newGame() {
//        var potentialNewTheme = defaultThemes.randomElement()!
//        if potentialNewTheme.content.count < 2 {
//            potentialNewTheme = defaultTheme
//        }
//        theme = potentialNewTheme
//        game = StringGame(theme: potentialNewTheme)
        game = StringGame(theme: theme)
    }
    
    func choose(_ card: Card) {
        game.choose(card)
    }
    
}

fileprivate extension Array where Element: Identifiable {
    subscript(id: Element.ID) -> Element? {
        self.first(where: {element in element.id == id})
    }
}

extension Color {
    init(fromString str: String?) {
        switch str {
        case "orange": self = .orange
        case "black": self = .black
        case "red": self = .red
        case "gray": self = .gray
        case "brown": self = .brown
        default: self = .accentColor
        }
    }
}
