//
//  VaccineTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 13/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class PestTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var fecha: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


