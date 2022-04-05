//
//  Options.swift
//  FruitMine
//
//  Created by AlexKotov on 11.03.22.
//

import Foundation

enum GameDifficults: Int {
    case easy = 4
    case middle = 5
    case hard = 6
    
    var lives: Int {
        switch self {
        case .easy:
            return 3
        case .middle:
            return 4
        case .hard:
            return 5
        }
    }
    
    var size: Int {
        switch self {
        case .easy:
            return 4
        case .middle:
            return 5
        case .hard:
            return 6
        }
    }
    
    var timer: Int {
        switch self {
        case .easy:
            return  3
        case .middle:
            return 4
        case .hard:
            return 5
        }
    }
    
    var bombs: Int {
        switch self {
        case .easy:
            return 5
        case .middle:
            return 8
        case .hard:
            return 10
        }
    }
    
    var streak: Int {
        switch self {
        case .easy:
            return 3
        case .middle:
            return 4
        case .hard:
            return 5
        }
    }
}

struct DefaultKeys {
    static let difficulty = "GameDifficulty"
    static let vibration = "GameVibaration"
    static let sound = "GameSound"
    static let score = "GameScore"
}

class Options {
    static let shared = Options()
    
    init() {
        if UserDefaults.standard.value(forKey: DefaultKeys.sound) == nil {
            sound = true
        }
        if UserDefaults.standard.value(forKey: DefaultKeys.vibration) == nil {
            vibration = true
        }
        if UserDefaults.standard.value(forKey: DefaultKeys.difficulty) == nil {
            difficulty = .easy
        }
    }
    
    var vibration: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultKeys.vibration)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: DefaultKeys.vibration)
        }
    }
    
    var sound: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: DefaultKeys.sound)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: DefaultKeys.sound)
        }
    }
    
    var difficulty: GameDifficults {
        set {
            let newValue = newValue.rawValue
            UserDefaults.standard.set(newValue, forKey: DefaultKeys.difficulty)
            UserDefaults.standard.synchronize()
        }
        get {
            return GameDifficults(rawValue: UserDefaults.standard.integer(forKey: DefaultKeys.difficulty)) ?? .easy
        }
    }
}
