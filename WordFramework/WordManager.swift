//
//  WordManager.swift
//  LingoLock
//
//

import Foundation

public struct Word: Codable {
   public let word: String
    public let definition: String
    
       public init(word: String, definition: String) {
           self.word = word
           self.definition = definition
       }
}

public class WordManager {
    public static let shared = WordManager()

    public private(set) var words: [Word] = []

    private init() {
        loadWords()
    }
    


    private func loadWords() {
        
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
            print("words.json file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            words = try decoder.decode([Word].self, from: data)
        } catch {
            print("Error loading or decoding words.json: \(error)")
        }
    }
}
