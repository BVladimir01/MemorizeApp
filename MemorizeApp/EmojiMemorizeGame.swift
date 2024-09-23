//
//  EmojiMemoryGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import SwiftUI

class EmojiMemorizeGame: ObservableObject {
    
    private static let defaultTheme = Theme(name: "Faces",
                                            numberOfPairsOfCards: 5,
                                            content: ["😀", "🤣", "😌", "😛", "🥸", "🤯", "🥰", "😡", "😎", "🥶"],
                                            color: "orange")
    
    private var themes: [Theme] = [defaultTheme] + defaultThemes
    
    var themeId: String = defaultTheme.id
    
    var theme: Theme<String> {
        if let potentialTheme = themes[themeId] {
            potentialTheme
        } else {
            EmojiMemorizeGame.defaultTheme
        }
    }
    
    @Published private var model = MemorizeGame(numberOfPairsOfCards: defaultTheme.numberOfPairsOfCards,
                                                cardsContents: defaultTheme.content)
    
    var cards: [MemorizeGame<String>.Card] {
        return model.cards
    }
    var score: Int {
        model.score
    }
    
    init(themes: [Theme<String>] = [defaultTheme] + defaultThemes,
         themeId: String = defaultTheme.id,
         model: MemorizeGame<String> = MemorizeGame(numberOfPairsOfCards: defaultTheme.numberOfPairsOfCards,
                                                    cardsContents: defaultTheme.content)) {
        self.themes = [EmojiMemorizeGame.defaultTheme] + defaultThemes + themes
        self.themeId = themeId
        self.model = model
    }
    
    // MARK: - Intents
    func newGame() {
        var potentialNewTheme = themes.randomElement() ?? EmojiMemorizeGame.defaultTheme
        if potentialNewTheme.content.count < 2 {
            potentialNewTheme = EmojiMemorizeGame.defaultTheme
        }
        model = MemorizeGame(numberOfPairsOfCards: potentialNewTheme.numberOfPairsOfCards,
                             cardsContents: potentialNewTheme.content)
        themeId = potentialNewTheme.id
        print(themeId)
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
    
}



fileprivate extension Array where Element: Identifiable {
    subscript(id: Element.ID) -> Element? {
        self.first(where: {element in element.id == id})
    }
}



private let defaultThemes = [
    Theme(name: "Cars",
          content: ["🚗", "🚕", "🚙", "🚎", "🚌", "🏎️", "🚓", "🚑"],
          color: "black"),
    Theme(name: "Fruits",
          numberOfPairsOfCards: 8,
          content: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈"],
          color: "red"),
    Theme(name: "Animals",
          content: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"]),
    Theme(name: "Balls",
          content: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"],
          color: "orange")
]

extension Color {
    init(fromString str: String?) {
        switch str {
        case "orange": self = .orange
        case "black": self = .black
        case "red": self = .red
        default: self = .accentColor
        }
    }
}
