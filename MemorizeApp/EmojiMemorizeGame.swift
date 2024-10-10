//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    typealias StringGameModel = MemorizeGameModel<String>
    typealias StringGame = StringGameModel.MemorizeGame<String>
    typealias Card = StringGame.Card
    
    @Published private var gameModel = StringGameModel(theme: MemorizeGameModel.defaultTheme)
    
    var themes = StringGameModel.defaultThemes
    
    var cards: [Card] {
        return gameModel.game.cards
    }
    
    var score: Int {
        gameModel.game.score
    }
    
    var themeId: String {
        gameModel.theme.id
    }
    
    var theme: StringGameModel.Theme<String> {
        gameModel.theme
    }
    
    
    var gameHasEnded: Bool {
        cards.filter( { !$0.isMatched }).count == 0
    }
    
    init(themes: [StringGameModel.Theme<String>] = StringGameModel.defaultThemes) {
        self.themes = themes
        self.gameModel = StringGameModel(theme: themes[0])
    }
    
    init(extraThemes: [StringGameModel.Theme<String>]) {
        self.themes = StringGameModel.defaultThemes + extraThemes
        self.gameModel = StringGameModel(theme: themes[0])
    }
    
    // MARK: - Intents
    func newGame() {
        var potentialNewTheme = themes.randomElement() ?? StringGameModel.defaultTheme
        if potentialNewTheme.content.count < 2 {
            potentialNewTheme = StringGameModel.defaultTheme
        }
        gameModel = StringGameModel(theme: potentialNewTheme)
    }
    
    func choose(_ card: Card) {
        gameModel.game.choose(card)
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
