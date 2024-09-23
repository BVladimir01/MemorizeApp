//
//  MemorizeGame.swift
//  MemorizeApp
//
//  Created by Vladimir on 20.09.2024.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private(set) var score: Int = 0
    
    init(numberOfPairsOfCards: Int, cardsContents: [CardContent]) {
        cards = []
        let shuffledConent = cardsContents.shuffled()
        for pairIndex in 0..<max(numberOfPairsOfCards, 2) {
            let content = shuffledConent[pairIndex]
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
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
                        score = max(0, score - descore)
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
    
//    mutating func shuffle() {
//        cards.shuffle()
//    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            return "\(id): \(content), \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        var isFaceUp = false
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

struct Theme<T>: Identifiable {
    
    
    let numberOfPairsOfCards: Int
    let content: [T]
    let color: String?
    var name: String
    var id: String {
        get { name }
        set { name = newValue}
    }
    
    init(name: String, numberOfPairsOfCards: Int, content: [T], color: String? = nil) {
        self.numberOfPairsOfCards = min(max(2, numberOfPairsOfCards), content.count)
        self.content = content
        self.color = color
        self.name = name
    }
    
    init(name: String, content: [T], color: String? = nil) {
        let numberOfPairsOfCards = content.count
        self.init(name: name, numberOfPairsOfCards: numberOfPairsOfCards, content: content, color: color)
    }
}

