//
//  AudioSource.swift
//  FruitMine
//
//  Created by AlexKotov on 12.03.22.
//

import Foundation

    
struct MusicFiles {
    static let background = Music(filename: "background", type: "mp3")
}

enum AudioEffect: String {
    case coins = "add_score"
    case correct = "correct"
    case bomb = "bomb"
    case background = "background"
}
