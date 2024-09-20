//
//  MemorizeAppApp.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
