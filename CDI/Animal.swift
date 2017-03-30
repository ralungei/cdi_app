//
//  Animal.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Animal {

    //MARK: Properties
    
    var idAnimal: String
    var tipo: String
    var codFamilia: String
    var raza: String
    var sexo: String
    var fecha: String
    var peso: Float
    var edad: Int
    var estado: String
    var cuarentena: Bool
    
    //MARK: Initialization
    
    init?(idAnimal: String, tipo:String, codFamilia: String, raza: String, sexo: String, fecha: String, peso: Float, edad: Int, estado: String, cuarentena: Bool) {
        
        // The name must not be empty
        guard !idAnimal.isEmpty else{
            return nil
        }
        
        // Initialize stored properties
        self.idAnimal = idAnimal
        self.tipo = tipo
        self.codFamilia = codFamilia
        self.raza = raza
        self.sexo = sexo
        self.fecha = fecha
        self.peso = peso
        self.edad = edad
        self.estado = estado
        self.cuarentena = cuarentena
    }
    
    
}
