//
//  ScoreStorage.swift
//  FruitMine
//
//  Created by AlexKotov on 5.04.22.
//

import Foundation

struct Score: Codable {
    var playerName: String
    var score: Int
}

class Storage {
    static let shared = Storage()
    
    var scores: [Score] {
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: DefaultKeys.score)
            UserDefaults.standard.synchronize()
        }
        get {
            let data = UserDefaults.standard.data(forKey: DefaultKeys.score) ?? Data()
            let scores = (try? JSONDecoder().decode([Score].self, from: data) ) ?? []
            return scores
        }
    }
}
