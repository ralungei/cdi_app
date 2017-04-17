//
//  Vaccine.swift
//  CDI
//
//  Created by ETSISI on 12/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Vaccine {
    
    //MARK: Properties
    
    var id: String
    var nombre: String
    var fecha: String
    
    
    //MARK: Initialization
    
    init?(id: String, nombre: String, fecha: String){
        self.id = id
        self.nombre = nombre
        self.fecha = fecha
    }
}

