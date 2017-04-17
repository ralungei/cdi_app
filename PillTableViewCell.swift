//
//  PillTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class PillTableViewCell: UITableViewCell {

    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var dosis: UILabel!
    @IBOutlet weak var toma: UILabel!
    @IBOutlet weak var fechaInicio: UILabel!
    @IBOutlet weak var fechaFin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
