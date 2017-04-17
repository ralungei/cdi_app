//
//  FeedingTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class FeedingTableViewCell: UITableViewCell {

    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var alimento: UILabel!
    @IBOutlet weak var cantidad: UILabel!
    @IBOutlet weak var tomas: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
