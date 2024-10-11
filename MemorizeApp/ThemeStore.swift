//
//  ThemeStore.swift
//  MemorizeApp
//
//  Created by Vladimir on 10.10.2024.
//

import Foundation
import SwiftUI


class ThemeStore: ObservableObject {
    typealias StringTheme = Theme<String>
    private let autosaveURL: URL = URL.documentsDirectory.appending(path: "Autosaved.stringthemes")
    
    @Published var themes: [StringTheme] {
        didSet {
            do {
                let data = try JSONEncoder().encode(themes)
                try data.write(to: autosaveURL)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    var currentThemeIndex: Int = 0
    
    init(themes: [StringTheme]) {
        if themes.isEmpty {
            self.themes = defaultThemes
            currentThemeIndex = 0
        } else {
            self.themes = themes
        }
        currentThemeIndex = 0
    }
    
    init() {
        if let data = try? Data(contentsOf: autosaveURL), let loadedThemes = try? JSONDecoder().decode([StringTheme].self, from: data) {
            if loadedThemes.isEmpty {
                self.themes = defaultThemes
            } else {
                self.themes = loadedThemes
            }
        } else {
            self.themes = defaultThemes
        }
        currentThemeIndex = 0
    }
    
    func deleteTheme(index: IndexSet) {
        themes.remove(atOffsets: index)
    }
    
    
    func getIndex(forId id: StringTheme.ID) -> Int? {
        themes.firstIndex(where: { $0.id == id })
    }
    
    func insertEmptyTheme() {
        themes.append(StringTheme())
        currentThemeIndex = themes.endIndex - 1
    }
    
}


extension Theme {
    func asString() -> String{
        var resString = ""
        for symbol in content {
            resString.append(symbol.description)
        }
        return resString
    }
}

extension String {
    mutating func remove(_ ch: Character) {
        removeAll(where: { $0 == ch })
    }
}

extension Character {
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1️⃣)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}

extension String {
    var uniqued: String {
        reduce(into: "") { sofar, element in
            if !sofar.contains(element) {
                sofar.append(element)
            }
        }
    }
    
    func asArray() -> [String] {
        var res = [String]()
        for char in self {
            res.append(String(char))
        }
        return res
    }
}

extension Array where Element: Hashable {
    func removedDuplicates() -> Array {
        var compareSet = Set<Element>()
        var res = Array<Element>()
        for item in self {
            if !compareSet.contains(item) {
                res.append(item)
                compareSet.insert(item)
            }
        }
        return res
    }
}



extension Color {
    init(rgba: RGBA?) {
        if let rgba {
            self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
        } else {
            self = .accentColor
        }
    }
}

extension RGBA {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
}


extension Theme where CardContent == String {
    init() {
        self.name = ""
        self.numberOfPairsOfCards = 2
        self.content = ["😀", "😁"]
        self.color = RGBA(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    }
}
