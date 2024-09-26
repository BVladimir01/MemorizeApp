//
//  FlyingNumber.swift
//  MemorizeApp
//
//  Created by Vladimir on 26.09.2024.
//

import SwiftUI

struct FlyingNumber: View {
    
    let number: Int

    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 5)
}
