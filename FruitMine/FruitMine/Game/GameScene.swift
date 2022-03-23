//
//  GameScene.swift
//  FruitMine
//
//  Created by AlexKotov on 10.03.22.
//

import SpriteKit
import GameplayKit

protocol GameProtocol: AnyObject {
    func showGameOverVC()
    func resetStartButton()
}

class GameScene: SKScene {
    weak var gameDelegate: GameProtocol?
    
    var cards: [Card] = []
    var bombs: [Card] = []
    var label: SKLabelNode?
    var livesLabel: SKLabelNode?
    var scoreLabel: SKLabelNode?
    
    var gameLogic: GameLogic = .init()
    let difficulty: GameDifficults = GameDifficults(rawValue: Options.shared.difficulty) ?? .easy
    
    var cardSize: CGSize {
        let count = CGFloat(difficulty.size)
        let cardWidth = (Constants.screenWidth - 40 - 5 * (count - 1)) / count
        return CGSize(width: cardWidth, height: cardWidth * 1.3)
    }
    
    override func didMove(to view: SKView) {
        setupField()
        setupLivesLabel()
        setupScorelabel()
        isUserInteractionEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        for node in touchedNodes {
            if let card = node as? Card {
                openCard(card)
                checkForBomb(card: card)
                checkForSpecial(card: card)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setupLivesLabel() {
        let livesLabel = SKLabelNode(fontNamed: "Rum Raisin")
        livesLabel.horizontalAlignmentMode = .center
        livesLabel.verticalAlignmentMode = .bottom
        livesLabel.fontSize = 20
        livesLabel.fontColor = .gray
        livesLabel.text = "Lives: \(gameLogic.livesCount)"
        livesLabel.position = CGPoint(x: -(Constants.screenWidth / 2) + livesLabel.frame.width / 2 + 20, y: Constants.screenHeight / 2 - (Constants.topPadding ?? 0) - 100)
        livesLabel.zPosition = ZOrder.label
        addChild(livesLabel)
        self.livesLabel = livesLabel
    }
    
    func setupScorelabel() {
        let scorelabel = SKLabelNode(fontNamed: "Rum Raisin")
        scorelabel.horizontalAlignmentMode = .center
        scorelabel.verticalAlignmentMode = .bottom
        scorelabel.fontSize = 20
        scorelabel.fontColor = .gray
        scorelabel.text = "\(gameLogic.score)"
        scorelabel.position = CGPoint(x: self.frame.maxX - scorelabel.frame.width / 2 - 20, y: Constants.screenHeight / 2 - (Constants.topPadding ?? 0) - 100)
        scorelabel.zPosition = ZOrder.label
        addChild(scorelabel)
        self.scoreLabel = scorelabel
        
        let label = SKLabelNode(fontNamed: "Rum Raisin")
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .bottom
        label.fontSize = 20
        label.fontColor = .gray
        label.text = "Score:"
        label.position = CGPoint(x: (scoreLabel?.frame.minX ?? 0)  - label.frame.width / 2 - 5, y: Constants.screenHeight / 2 - (Constants.topPadding ?? 0) - 100)
        scorelabel.zPosition = ZOrder.label
        addChild(label)
        self.label = label
        
    }
    
    func setupField() {
        let count = difficulty.size
        
        let startPoint = CGPoint(x: -(cardSize.width * CGFloat(count) + Constants.cardSpacing * CGFloat(count - 1)) / 2 + cardSize.width / 2, y: -(cardSize.height * CGFloat(count)) / 2 - 50 + cardSize.height / 2)

        var currentY = startPoint.y
        var cards = [Card]()
        
        for _ in 0...(count - 1) {
            var currentX = startPoint.x
            for _ in 0...(count - 1) {
                let card = NodeBuilder.createCard(size: cardSize)
                card.position = CGPoint(x: currentX, y: currentY)
                addChild(card)
                currentX += card.size.width + Constants.cardSpacing
                cards.append(card)
            }
            currentY += cardSize.height + Constants.cardSpacing
        }
        self.cards = cards
        
        setBombs()
    }
    
    func setBombs() {
        let bombCount = difficulty.bombs
        var copyCards = self.cards
        for _ in 0...(bombCount - 1) {
            guard let randomCard = copyCards.randomElement() else { return }
            randomCard.isBomb = true
            copyCards = copyCards.filter { $0 != randomCard }
            bombs.append(randomCard)
        }
        setSpecialCard(in: copyCards)
    }
    
    func setSpecialCard(in cards: [Card]) {
        guard difficulty == .hard else { return }
        guard let randomCard = cards.randomElement() else { return }
        randomCard.isSpecial = true
    }
    
    func openCard(_ card: Card) {
        let scaleDownX = SKAction.scaleX(to: 0, duration: 0.15)
        let change = SKAction.run {
            card.isOpened.toggle()
        }
        let scaleUpX = SKAction.scaleX(to: 1, duration: 0.15)
        let seq = SKAction.sequence([scaleDownX, change, scaleUpX])
        card.run(seq, completion: {
        })
    }
    
    func increaseScore(currentStreak: Int) {
        let scaleUp = SKAction.scale(to: 1.3, duration: 0.05)
        let scaleDown = SKAction.scale(to: 1, duration: 0.05)
        let addScore = SKAction.run { [weak self] in
            self?.gameLogic.addScore(currentStreak: currentStreak)
            self?.updateScoreLabel()
        }
        let seq = SKAction.sequence([scaleUp, addScore, scaleDown])
        let repeatAction = SKAction.repeat(seq, count: 10)
        scoreLabel?.run(repeatAction)
    }
    
    func openAllCards(completion: (() -> Void)? = nil) {
        for card in cards {
            openCard(card)
        }
        completion?()
    }
    
    func checkForBomb(card: Card) {
        cards = cards.filter { $0 != card }
        if card.isBomb {
            gameLogic.zeroStreak()
            updateLivesLabel()
            AudioManager.shared.play(effect: .bomb, node: card)
            VibrationManager.shared.heavyImpact()
            if gameLogic.livesCount == 0 {
                self.gameDelegate?.showGameOverVC()
            }
        } else {
            gameLogic.increaseStreak()
            if gameLogic.checkForStreak() {
                increaseScore(currentStreak: gameLogic.currentStreak)
                animateScoreIncrease(card: card)
            }
            updateLivesLabel()
            updateScoreLabel()
            AudioManager.shared.play(effect: .correct, node: self)
            checkForWIn()
        }
    }
    
    func checkForWIn() {
        if cards.filter({ !$0.isBomb }).isEmpty {
            print("youwin")
            openAllCards() {
                let wait = SKAction.wait(forDuration: 1)
                let completion = SKAction.run {
                    self.openAllCards() {
                        let reset = SKAction.run {
                            for child in self.children {
                                if child.name == "card" {
                                    child.removeFromParent()
                                }
                            }
                            self.isUserInteractionEnabled = false
                            self.gameDelegate?.resetStartButton()
                            self.setupField()
                        }
                        self.run(SKAction.sequence([wait, reset]))
                    }
                }
                self.run(SKAction.sequence([wait, completion]))
            }
            
        }
    }
    
    func checkForSpecial(card: Card) {
        if card.isSpecial {
            showCards()
        }
    }
    
    func animateScoreIncrease(card: Card) {
        let splash = NodeBuilder.createGoldSplash()
        let addSplash = SKAction.customAction(withDuration: 0) {_, _ in
            splash.position = card.position
            self.addChild(splash)
            AudioManager.shared.play(effect: .coins, node: self)
        }
        let deleteSplash = SKAction.customAction(withDuration: 0) {_, _ in
            splash.removeFromParent()
        }
        let seq = SKAction.sequence([addSplash, .wait(forDuration: 0.5), deleteSplash])
        card.run(seq)
    }
    
    func updateLivesLabel() {
        livesLabel?.text = "Lives: \(gameLogic.livesCount)"
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = "\(gameLogic.score)"
        scoreLabel?.position = CGPoint(x: self.frame.maxX - (scoreLabel?.frame.width ?? 0) / 2 - 20, y: Constants.screenHeight / 2 - (Constants.topPadding ?? 0) - 100)
        label?.position = CGPoint(x: (scoreLabel?.frame.minX ?? 0)  - (label?.frame.width ?? 0) / 2 - 5, y: Constants.screenHeight / 2 - (Constants.topPadding ?? 0) - 100)
    }
    
    func showCards() {
        let delay = Double(difficulty.timer)
        openAllCards()
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.openAllCards()
            self.isUserInteractionEnabled = true
        }
    }
}

extension GameScene: GameViewControllerDelegate {
    func startGame() {
        showCards()
    }
}