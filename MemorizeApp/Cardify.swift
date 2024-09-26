
//  Cardify.swift
//  MemorizeApp
//
//  Created by Vladimir on 26.09.2024.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    init(isFaceUp: Bool, isMatched: Bool) {
        self.isMatched = isMatched
        self.rotation = isFaceUp ? 0 : .pi
    }
    
    var isFaceUp: Bool {
        rotation < .pi / 2
    }
    
    let isMatched: Bool
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.borderWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .opacity(rotation == .pi && isMatched ? 0 : 1)
        .animation(.easeInOut, value: rotation == .pi && isMatched)
        .rotation3DEffect(.radians(rotation),
                          axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    private struct Constants {
        static let borderWidth = CGFloat(3)
        static let cornerRadius = CGFloat(10)
    }
}


extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
