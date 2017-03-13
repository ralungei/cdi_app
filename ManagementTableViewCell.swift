//
//  ManagementTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 6/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class ManagementTableViewCell: UITableViewCell {

    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var sexo: UILabel!
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
