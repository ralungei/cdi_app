//
//  Vaccine.swift
//  CDI
//
//  Created by ETSISI on 12/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Pill {
    
    //MARK: Properties
    
    var id: String
    var nombre: String
    var dosis: String
    var toma: String
    var fechaInicio: String
    var fechaFin: String
    
    
    //MARK: Initialization
    
    init?(id: String, nombre: String, dosis: String, toma: String, fechaInicio: String, fechaFin: String){
        self.id = id
        self.nombre = nombre
        self.dosis = dosis
        self.toma = toma
        self.fechaInicio = fechaInicio
        self.fechaFin = fechaFin
    }
}

