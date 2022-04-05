//
//  GameViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 10.03.22.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameViewControllerDelegate: AnyObject {
    func startGame()
}

class GameViewController: UIViewController {
    weak var delegate: GameViewControllerDelegate?
    var scene: GameScene?
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let skView = view as! SKView
        self.delegate = scene
        scene?.gameDelegate = self
        skView.ignoresSiblingOrder = true
        scene?.scaleMode = .resizeFill
        skView.presentScene(scene)
        
        navigationController?.isNavigationBarHidden = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        scene?.startGame()
        startButton.isHidden = true
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension GameViewController: GameProtocol {
    func showGameOverVC(score: Int) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "GameOverViewController") as? GameOverViewController else { return }
        vc.delegate = self
        vc.score = score
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func resetStartButton() {
        startButton.isHidden = false
    }
}

extension GameViewController: GameOverViewControllerDelegate {
    func goHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
