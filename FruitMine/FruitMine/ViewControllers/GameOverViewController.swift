//
//  GameOverViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 22.03.22.
//

import UIKit

protocol GameOverViewControllerDelegate: AnyObject {
    func goHome()
}

class GameOverViewController: UIViewController {
    weak var delegate: GameOverViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: false) {
            self.delegate?.goHome()
        }
        
    }
}
