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

struct OptionsKey {
    static let difficulty = "kGameDifficulty"
    static let vibration = "kGameVibaration"
    static let sound = "kGameSound"
}

class Options {
    static let shared = Options()
    
    init() {
        if UserDefaults.standard.value(forKey: OptionsKey.sound) == nil {
            sound = true
        }
        if UserDefaults.standard.value(forKey: OptionsKey.vibration) == nil {
            vibration = true
        }
        if UserDefaults.standard.value(forKey: OptionsKey.difficulty) == nil {
            difficulty = GameDifficults.easy.rawValue
        }
    }
    
    var vibration: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: OptionsKey.vibration)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: OptionsKey.vibration)
        }
    }
    
    var sound: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: OptionsKey.sound)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: OptionsKey.sound)
        }
    }
    
    var difficulty: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: OptionsKey.difficulty)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: OptionsKey.difficulty)
        }
    }
}
