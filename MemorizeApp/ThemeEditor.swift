//
//  ThemeEditor.swift
//  MemorizeApp
//
//  Created by Vladimir on 10.10.2024.
//

import SwiftUI

struct ThemeEditor: View {
    
    typealias StringTheme = Theme<String>
    @Binding var theme: StringTheme
    @State var chosenColor: Color
    @State var inputEmojis: String = ""
    @State var chosenPairNum: Int = 1
    
    @FocusState private var focused: Bool
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $theme.name)
                    .keyboardType(.asciiCapable)
                    .focused($focused)
            } header: {
                Text("Name")
            }
            Section {
                ColorPicker("Choose theme color", selection: $chosenColor, supportsOpacity: false)
                    .onChange(of: chosenColor) {
                        theme.color = RGBA(color: chosenColor)
                    }
            } header: {
                Text("Color")
            }
            Section {
                TextField("Add Emojis Here", text: $inputEmojis)
                    .onChange(of: inputEmojis) {
                        let emojiString = inputEmojis.uniqued
                        let newEmojisArray = emojiString.asArray()
                        theme.content = (theme.content + newEmojisArray).removedDuplicates()
                    }
                deletebleEmojis
                    .animation(.easeInOut, value: theme.content)
            } header: {
                Text("Emojis")
            }
            Section {
                Picker("number picker", selection: $theme.numberOfPairsOfCards) {
                    ForEach(2...theme.content.count, id: \.self) { num in
                        Text("\(num)")
                    }
                }
            } header: {
                Text("Number of pairs")
            } footer: {
                Text("How many cards do you want in your game?")
            }
            .pickerStyle(.wheel)
        }
        .onAppear {
            if theme.name == "" {
                focused = true
            }
        }
    }
    
    var deletebleEmojis: some View {
        VStack(alignment: .trailing) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.content, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                if let index = theme.content.firstIndex(where: { $0 == emoji }) {
                                    theme.content.remove(at: index)
                                }
                            }
                        }
                }
            }
            Text("Tap to remove Emojis").font(.caption).foregroundStyle(.gray)
        }
    }
}
