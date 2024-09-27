//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import Foundation


struct MemorizeGameModel<CardConent: Equatable> {

    var game: MemorizeGame<CardConent>
    let theme: Theme<CardConent>
    
    init(theme: Theme<CardConent>) {
        self.theme = theme
        game = MemorizeGame<CardConent>(numberOfPairsOfCards: theme.numberOfPairsOfCards, cardsContents: theme.content)
    }
    
    struct MemorizeGame<CardContent: Equatable> {
        
        private(set) var cards: [Card]
        private(set) var score: Int = 0
        
        private var chosenCards: [Card] {
            cards.filter { $0.isFaceUp }
        }
        
        var allMatched: Bool { cards.allSatisfy { $0.isMatched} }
        
        init(numberOfPairsOfCards: Int, cardsContents: [CardContent]) {
            cards = []
            for pairIndex in 0..<max(numberOfPairsOfCards, 2) {
                let content = cardsContents[pairIndex]
                cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
                cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
            }
//            cards.shuffle()
        }
        
        var indexOfOneAndOnly: Int? {
            get { cards.indices.filter{ index in cards[index].isFaceUp }.only }
            set { cards.indices.forEach { index in
                if cards[index].isFaceUp { cards[index].alreadySeen = true }
                cards[index].isFaceUp = (newValue == index)
            } }
        }
        
        mutating func choose(_ card: Card) {
            if let chosenIndex = cards.firstIndex(where: {$0.id == card.id})
            {
                if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched
                {
                    if let potentialMatchIndex = indexOfOneAndOnly
                    {
                        if cards[chosenIndex].content == cards[potentialMatchIndex].content
                        {
                            cards[chosenIndex].isMatched = true
                            cards[potentialMatchIndex].isMatched = true
                            score += 2
                        }
                        else
                        {
                            var descore = 0
                            if cards[chosenIndex].alreadySeen {descore += 1}
                            if cards[potentialMatchIndex].alreadySeen {descore += 1}
//                            score = max(0, score - descore)
                            score -= descore
                        }
                    }
                    else
                    {
                        indexOfOneAndOnly = chosenIndex
                    }
                    cards[chosenIndex].isFaceUp = true
                }
            }
        }
        
//        mutating func choose(_ card: Card) {
//            if let chosenIndex = index(of: card) {
//                switch chosenCards.count {
//                case 0:
//                    cards[chosenIndex].isFaceUp = true
//                case 1:
//                    if chosenIndex != index(of: chosenCards[0]) {
//                        cards[chosenIndex].isFaceUp = true
//                    }
//                case 2:
//                    if Card.match(chosenCards) {
//                        let index1 = index(of: chosenCards[0])!
//                        let index2 = index(of: chosenCards[1])!
//                        cards[index1].isMatched = true
//                        cards[index1].isMatched = true
//                        
//                    }
//                default:
//                    break
//                }
//            } else {
//                fatalError("no such index")
//            }
//        }
        
        private func index(of card: Card) -> Int? {
            for index in cards.indices {
                if cards[index].id == card.id {
                    return index
                }
            }
            return nil
        }
        
        
        struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
            
            static func match(_ card1: Card, _ card2: Card) -> Bool{
                return card1.content == card2.content
            }
            static func match(_ cards: [Card]) -> Bool {
                return match(cards[0], cards[1])
            }
            
            var debugDescription: String {
                return "\(id): \(content), \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
            }
            
            var isFaceUp = false {
                didSet {
                    if oldValue && !isFaceUp {
                        alreadySeen = true
                    }
                }
            }
            var isMatched = false
            var alreadySeen = false

            let content: CardContent
            
            var id: String
        }
    }
    
    struct Theme<CardContent>: Identifiable {
        
        let numberOfPairsOfCards: Int
        let content: [CardContent]
        let color: String?
        var name: String
        var id: String {
            get { name }
            set { name = newValue}
        }
        
        init(name: String, numberOfPairsOfCards: Int, content: [CardContent], color: String? = nil) {
            self.numberOfPairsOfCards = min(max(2, numberOfPairsOfCards), content.count)
            self.content = content
            self.color = color
            self.name = name
        }
        
        init(name: String, content: [CardContent], color: String? = nil) {
            let numberOfPairsOfCards = content.count
            self.init(name: name, numberOfPairsOfCards: numberOfPairsOfCards, content: content, color: color)
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}


extension MemorizeGameModel where CardConent == String {
    static let defaultThemes = [
        Theme(name: "Faces",
              numberOfPairsOfCards: 5,
              content: ["😀", "🤣", "😌", "😛", "🥸", "🤯", "🥰", "😡", "😎", "🥶"],
              color: "orange"),
        Theme(name: "Cars",
              content: ["🚗", "🚕", "🚙", "🚎", "🚌", "🏎️", "🚓", "🚑"],
              color: "gray"),
        Theme(name: "Fruits",
              numberOfPairsOfCards: 10,
              content: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈"],
              color: "red"),
        Theme(name: "Animals",
              content: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊"]),
        Theme(name: "Balls",
              content: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🎱"],
              color: "brown")
    ]
    
    static let defaultTheme = Theme(name: "Faces",
                                    numberOfPairsOfCards: 5,
                                    content: ["😀", "🤣", "😌", "😛", "🥸", "🤯", "🥰", "😡", "😎", "🥶"],
                                    color: "orange")
}
