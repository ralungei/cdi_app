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
    
    var nombre: String
    var fecha: String
    var dosis: String
    
    
    //MARK: Initialization
    
    init?(nombre: String, fecha: String, dosis: String){
        self.nombre = nombre
        self.fecha = fecha
        self.dosis = dosis
    }
}

