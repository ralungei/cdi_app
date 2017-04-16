//
//  Vaccine.swift
//  CDI
//
//  Created by ETSISI on 12/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Pest {
    
    //MARK: Properties
    
    var id: String
    var tipo: String
    var fecha: String
    
    
    //MARK: Initialization
    
    init?(id: String, tipo: String, fecha: String){
        self.id = id
        self.tipo = tipo
        self.fecha = fecha
    }
}

