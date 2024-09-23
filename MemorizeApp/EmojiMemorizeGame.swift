//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    @Published private var gameModel = MemorizeGameModel<String>(theme: MemorizeGameModel.defaultTheme)
    
    var themes = MemorizeGameModel<String>.defaultThemes
    
    var cards: [MemorizeGameModel<String>.MemorizeGame<String>.Card] {
        return gameModel.game.cards
    }
    
    var score: Int {
        gameModel.game.score
    }
    
    var themeId: String {
        gameModel.theme.id
    }
    
    var theme: MemorizeGameModel<String>.Theme<String> {
        gameModel.theme
    }
    
    init(themes: [MemorizeGameModel<String>.Theme<String>] = MemorizeGameModel<String>.defaultThemes) {
        self.themes = themes
        self.gameModel = MemorizeGameModel<String>(theme: themes[0])
    }
    
    init(extraThemes: [MemorizeGameModel<String>.Theme<String>]) {
        self.themes = MemorizeGameModel<String>.defaultThemes + extraThemes
        self.gameModel = MemorizeGameModel<String>(theme: themes[0])
    }
    
    // MARK: - Intents
    func newGame() {
        var potentialNewTheme = themes.randomElement() ?? MemorizeGameModel<String>.defaultTheme
        if potentialNewTheme.content.count < 2 {
            potentialNewTheme = MemorizeGameModel<String>.defaultTheme
        }
        gameModel = MemorizeGameModel<String>(theme: potentialNewTheme)
    }
    
    func choose(_ card: MemorizeGameModel<String>.MemorizeGame<String>.Card) {
        gameModel.game.choose(card)
        if gameModel.game.allMatched {newGame()}
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
