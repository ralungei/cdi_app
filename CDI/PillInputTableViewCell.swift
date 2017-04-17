//
//  PillInputTableViewCell.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class PillInputTableViewCell: UITableViewCell {

    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var dosis: UITextField!
    @IBOutlet weak var fechaInicio: UITextField!
    @IBOutlet weak var fechaFin: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
