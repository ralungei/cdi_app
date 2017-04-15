//
//  VaccineTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 13/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class VaccineTableViewCell: UITableViewCell {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var fecha: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


