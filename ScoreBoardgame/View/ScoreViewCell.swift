//
//  ScoreViewCell.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 16/7/22.
//

import UIKit

class ScoreViewCell: UITableViewCell {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
