//
//  MenuViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 22.03.22.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        if Options.shared.sound {
            AudioManager.shared.play(music: MusicFiles.background)

        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if Options.shared.sound {
            AudioManager.shared.play(music: MusicFiles.background)
        }
    }
}
