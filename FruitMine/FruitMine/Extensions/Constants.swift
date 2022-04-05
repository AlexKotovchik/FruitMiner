//
//  Constants.swift
//  FruitMine
//
//  Created by AlexKotov on 5.04.22.
//

import Foundation
import SpriteKit

struct Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    static var cardWidth: CGFloat {
        let count = CGFloat(Options.shared.difficulty.size)
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
