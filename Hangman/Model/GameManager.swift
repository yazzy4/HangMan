//
//  GameManager.swift
//  Hangman
//
//  Created by Yaz Burrell on 5/5/21.
//

import Foundation

protocol GameProtocol: AnyObject {
    func gameDataFetched(_ data: [String])
}

class GameManager  {
    
    weak var delegate: GameProtocol?

    func fetchData() {
        var wordStrings = [String]()
        
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: fileURL){
                var lines = words.components(separatedBy: "\n")
                
                lines.shuffle()
                wordStrings += lines
            }
        } else {
            fatalError("No words found!")
        }
        
        delegate?.gameDataFetched(wordStrings)
    }



}
