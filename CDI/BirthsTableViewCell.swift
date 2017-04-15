//
//  BirthsTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 14/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class BirthsTableViewCell: UITableViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var idAnimal: UILabel!
    @IBOutlet weak var nombre: UILabel!
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
