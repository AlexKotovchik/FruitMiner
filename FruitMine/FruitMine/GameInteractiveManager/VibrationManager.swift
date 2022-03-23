//
//  VibrationManager.swift
//  FruitMine
//
//  Created by AlexKotov on 22.03.22.
//

import Foundation
import AudioToolbox.AudioServices
import GameplayKit

class VibrationManager: NSObject {

    static let shared = VibrationManager()
    
    func lightImpact() {
        guard Options.shared.vibration else {
            return
        }
        
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    func heavyImpact() {
        guard Options.shared.vibration else {
            return
        }
        
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    func cancelVibration() {
        guard Options.shared.vibration else {
            return
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
}
