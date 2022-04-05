//
//  SKAction+Extensions.swift
//  FruitMine
//
//  Created by AlexKotov on 15.03.22.
//

import Foundation
import SpriteKit

extension SKAction {
    static func play(effect: AudioEffect) -> SKAction {
        .playSoundFileNamed(effect.rawValue, waitForCompletion: false)
    }
    
}
