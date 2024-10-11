//
//  MemorizeAppApp.swift
//  MemorizeApp
//
//  Created by Vladimir on 19.09.2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
//    @StateObject var game = EmojiMemorizeGame(theme: defaultTheme)
    @StateObject var themeStore = ThemeStore()
    var body: some Scene {
        WindowGroup {
            ThemeListView(themeStore: themeStore)
        }
    }
}
