//
//  GameLogic.swift
//  FruitMine
//
//  Created by AlexKotov on 12.03.22.
//

import Foundation

class GameLogic {
    var currentStreak: Int = 0
    var score: Int = 0
    
    let difficulty: GameDifficults = Options.shared.difficulty
    var livesCount: Int = Options.shared.difficulty.lives
    
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
        if checkForStreak(currentStreak: currentStreak) {
            score += (100 + 100 * (currentStreak - streak)) / 10
        } else {
            score += 100 / 10
        }
    }
    
    func checkForStreak(currentStreak: Int) -> Bool {
        let streak = difficulty.streak
        return currentStreak >= streak
    }
}
