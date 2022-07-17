//
//  GameSocoreViewCell.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 17/7/22.
//

import UIKit

class GameSocoreViewCell: UITableViewCell {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
