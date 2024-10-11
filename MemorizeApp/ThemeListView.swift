//
//  ThemeEditor.swift
//  MemorizeApp
//
//  Created by Vladimir on 10.10.2024.
//

import SwiftUI

struct ThemeListView: View {
    
    typealias StringTheme = Theme<String>
    @ObservedObject var themeStore: ThemeStore
    @State var showEditor = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(themeStore.themes) { theme in
                    NavigationLink(value: theme.id) {
                        VStack(alignment: .leading) {
                            Text("\(theme.name): \(theme.numberOfPairsOfCards) pairs")
                                .foregroundStyle(Color(rgba: theme.color))
                            Text(theme.asString())
                                .lineLimit(1)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            withAnimation(.easeInOut) {
                                if let index = themeStore.getIndex(forId: theme.id) {
                                    themeStore.themes.remove(at: index)
                                }
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button() {
                            if let index = themeStore.getIndex(forId: theme.id) {
                                themeStore.currentThemeIndex = index
                                showEditor = true
                            }
                        } label: {
                            Label("Edit", systemImage: "pencil")
                                .tint(.indigo)
                        }
                    }
                }
            }
            .navigationTitle("Themes")
            .navigationDestination(for: StringTheme.ID.self) {themeId in
                if let index = themeStore.getIndex(forId: themeId) {
                    MemorizeGameView(viewModel: EmojiMemorizeGame(theme: themeStore.themes[index]))
                }
            }
            .sheet(isPresented: $showEditor) {
                ThemeEditor(theme: $themeStore.themes[themeStore.currentThemeIndex],
                            chosenColor: Color(rgba: themeStore.themes[themeStore.currentThemeIndex].color))
            }
            .toolbar {
                Button {
                    themeStore.insertEmptyTheme()
                    showEditor = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    
    init(themeStore: ThemeStore) {
        self.themeStore = themeStore
    }
    
    init() {
        self.themeStore = ThemeStore()
    }
}

#Preview {
    ThemeListView(themeStore: ThemeStore(themes: defaultThemes))
}
