//
//  ItemCell.swift
//  FetchTestApp
//
//  Created by Luke Morse on 1/19/20.
//  Copyright © 2020 Luke Morse. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var listIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
