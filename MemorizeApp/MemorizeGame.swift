//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import Foundation

struct MemorizeGame<CardContent: CustomStringConvertible & Equatable & Codable>{
    
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
            cards.shuffle()
    }
    
    init(theme: Theme<CardContent>) {
        let numberOfPairsOfCards = theme.numberOfPairsOfCards
        let cardsContents = theme.content
        self.init(numberOfPairsOfCards: numberOfPairsOfCards, cardsContents: cardsContents)
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


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

