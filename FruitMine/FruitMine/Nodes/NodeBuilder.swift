//
//  NodeBuilder.swift
//  FruitMine
//
//  Created by AlexKotov on 11.03.22.
//

import Foundation
import SpriteKit

enum CardNames: Int, CaseIterable {
    case item0 = 0
    case item1 = 1
    case item2 = 2
    case item3 = 3
    case item4 = 4
    
    var name: String {
        return "fruit_\(self.rawValue)"
    }
}

struct Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static var cardWidth: CGFloat {
        let count = CGFloat(GameDifficults(rawValue: Options.shared.difficulty)?.size ?? 4)
        return (screenWidth - 40 - 5 * (count - 1)) / count
    }
    static let cardSpacing: CGFloat = 5
    static let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top
}

struct ZOrder {
    static let background: CGFloat = 0
    static let field: CGFloat = 5
    static let card: CGFloat = 10
    static let label: CGFloat = 10
    static let emitters: CGFloat = 20
}

class NodeBuilder {
    static func createCard(size: CGSize) -> Card {
        let card = Card(size: size)
        card.zPosition = ZOrder.card
        return card
    }
    
    static func createGoldSplash() -> SKEmitterNode {
        guard let emitter = SKEmitterNode(fileNamed: "GoldParticles") else { return SKEmitterNode() }
        emitter.particleSize = CGSize(width: 7, height: 7)
        emitter.zPosition = ZOrder.emitters
        return emitter
    }
}

class Card: SKSpriteNode {
    var openedTextureName: String = ""
    var isSpecial: Bool = false {
        willSet {
            guard newValue else { return }
            self.openedTextureName = "special"
        }
    }
    var isBomb: Bool = false {
        willSet {
            guard newValue else { return }
            self.openedTextureName = "bomb"
        }
    }
    
    var isOpened: Bool = false {
        didSet {
            let textureName = isOpened ? openedTextureName : "closed_card"
            self.texture = SKTexture(imageNamed: textureName)
            self.isUserInteractionEnabled.toggle()
        }
    }
    
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "closed_card")
        super.init(texture: texture, color: .clear, size: size)
        setRandomOpenedTexture()
        name = "card"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRandomOpenedTexture() {
        let cardNames = CardNames.allCases
        let randomCardName = cardNames.randomElement()?.name
        openedTextureName = randomCardName ?? "fruit_1"
    }
}

