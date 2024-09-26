
//  Cardify.swift
//  MemorizeApp
//
//  Created by Vladimir on 26.09.2024.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    let isFaceUp: Bool
    let isMatched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.borderWidth)
                content
                    .font(.system(size: Constants.textFontSize))
                    .minimumScaleFactor(Constants.minScaleFactor)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .opacity(isFaceUp || !isMatched ? 1 : 0)
    }
    
    private struct Constants {
        static let textFontSize = CGFloat(200)
        static let borderWidth = CGFloat(3)
        static let minScaleFactor = CGFloat(0.01)
        static let cornerRadius = CGFloat(10)
    }
}


extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
