//
//  InfoDetailViewCell.swift
//  ScoreBoardgame
//
//  Created by Marcos Mejias on 16/4/22.
//

import UIKit

class InfoDetailViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellKey: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
