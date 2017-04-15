//
//  Animal.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Birth {

    //MARK: Properties
    
    var idAnimal: String
    var criasMacho: Int
    var criasHembra: Int
    var criasMuertas: Int
    var fecha: String
    var descripcion: String

    //MARK: Initialization
    
    init(idAnimal: String, criasMacho: Int, criasHembra: Int, criasMuertas: Int, fecha: String, descripcion: String) {
        // Initialize stored properties
        self.idAnimal = idAnimal
        self.criasMacho = criasMacho
        self.criasHembra = criasHembra
        self.criasMuertas = criasMuertas
        self.fecha = fecha
        self.descripcion = descripcion
    }
    
}
