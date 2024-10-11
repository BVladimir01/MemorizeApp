//
//  GameTheme.swift
//  MemorizeApp
//
//  Created by Vladimir on 10.10.2024.
//

import Foundation


struct Theme<CardContent: CustomStringConvertible & Codable>: Identifiable, Codable {
    
    var numberOfPairsOfCards: Int {
        didSet {
            if numberOfPairsOfCards < 2 {
                numberOfPairsOfCards = oldValue
            }
        }
    }
    var content: [CardContent] {
        willSet {
            numberOfPairsOfCards = min(numberOfPairsOfCards, newValue.count)
        }
        didSet {
            if content.count < 2 {
                content = oldValue
            }
        }
    }
    
    var color: RGBA? = RGBA(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var name: String
    var id = UUID()
    
    init(name: String, numberOfPairsOfCards: Int, content: [CardContent]) {
        self.numberOfPairsOfCards = min(max(2, numberOfPairsOfCards), content.count)
        self.content = content
        self.name = name
    }
    
    init(name: String, content: [CardContent], color: String? = nil) {
        let numberOfPairsOfCards = content.count
        self.init(name: name, numberOfPairsOfCards: numberOfPairsOfCards, content: content)
    }
}


let defaultThemes = [
        Theme(name: "Faces",
              numberOfPairsOfCards: 5,
              content: ["😀", "🤣", "😌", "😛", "🥸", "🤯", "🥰", "😡", "😎", "🥶"]),
        Theme(name: "Cars",
              content: ["🚗", "🚕", "🚙", "🚎", "🚌", "🏎️", "🚓", "🚑"]),
        Theme(name: "Fruits",
              numberOfPairsOfCards: 10,
              content: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈"]),
        Theme(name: "Animals",
              content: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"]),
        Theme(name: "Balls",
              content: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"])
        ]
    
let defaultTheme = Theme(name: "Faces",
                         numberOfPairsOfCards: 5,
                         content: ["😀", "🤣", "😌", "😛", "🥸", "🤯", "🥰", "😡", "😎", "🥶"])



struct RGBA: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
