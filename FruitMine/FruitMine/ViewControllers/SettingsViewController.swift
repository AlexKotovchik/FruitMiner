//
//  SettingsViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 22.03.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var easyLevelButton: UIButton!
    @IBOutlet weak var middleLevelButton: UIButton!
    @IBOutlet weak var hardLevelButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var vibroButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch Options.shared.difficulty {
        case GameDifficults.easy:
            easyLevelChoosen()
        case GameDifficults.middle:
            middleLevelChoosen()
        case GameDifficults.hard:
            highLevelChoosen()
        default:
            easyLevelChoosen()
        }
        soundButton.isSelected = Options.shared.sound
        vibroButton.isSelected = Options.shared.vibration
    }
    
    @IBAction func homeTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func easyLevelTapped(_ sender: UIButton) {
        easyLevelButton.isHighlighted = !easyLevelButton.isHighlighted
        easyLevelChoosen()
    }
    
    @IBAction func middleLevelTapped(_ sender: UIButton) {
        middleLevelChoosen()
    }
    
    @IBAction func hardlevelTapped(_ sender: UIButton) {
        highLevelChoosen()
    }
    
    @IBAction func soundTapped(_ sender: UIButton) {
        soundButton.isSelected = !soundButton.isSelected
        Options.shared.sound = soundButton.isSelected
        if Options.shared.sound == false {
            AudioManager.shared.pause()
        } else {
            AudioManager.shared.play(music: MusicFiles.background)
        }
    }
    
    @IBAction func vibroTapped(_ sender: UIButton) {
        vibroButton.isSelected = !vibroButton.isSelected
        Options.shared.vibration = vibroButton.isSelected
    }
    
    func easyLevelChoosen() {
        Options.shared.difficulty = GameDifficults.easy
        easyLevelButton.isSelected = true
        middleLevelButton.isSelected = false
        hardLevelButton.isSelected = false
    }

    func middleLevelChoosen() {
        Options.shared.difficulty = GameDifficults.middle
        easyLevelButton.isSelected = false
        middleLevelButton.isSelected = true
        hardLevelButton.isSelected = false
    }
    func highLevelChoosen() {
        Options.shared.difficulty = GameDifficults.hard
        easyLevelButton.isSelected = false
        middleLevelButton.isSelected = false
        hardLevelButton.isSelected = true
    }

}
