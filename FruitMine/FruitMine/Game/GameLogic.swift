//
//  GameLogic.swift
//  FruitMine
//
//  Created by AlexKotov on 12.03.22.
//

import Foundation

class GameLogic {
    var livesCount: Int = 3
    var currentStreak = 0
    var score = 0
    
    let difficulty = Options.shared.difficulty
    
    func increaseStreak() {
        currentStreak += 1
    }
    
    func zeroStreak() {
        currentStreak = 0
        reduceLife()
    }
    
    func reduceLife() {
        livesCount -= 1
    }
    
//    func addLife() {
//        let streak = Options.shared.difficulty.streak
//        if currentStreak % streak == 0 {
//            livesCount += 1
//        }
//    }
    
    func addScore(currentStreak: Int) {
        let streak = difficulty.streak
        score += (100 + 100 * (currentStreak - streak)) / 10
    }
    
    func checkForStreak() -> Bool {
        let streak = difficulty.streak
        return currentStreak >= streak
    }
}
