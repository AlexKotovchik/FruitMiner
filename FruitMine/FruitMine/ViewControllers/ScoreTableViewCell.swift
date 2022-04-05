//
//  ScoreTableViewCell.swift
//  FruitMine
//
//  Created by AlexKotov on 5.04.22.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
