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
        zPosition = ZOrder.card
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

