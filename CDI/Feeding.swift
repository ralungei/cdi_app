//
//  Feeding.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Feeding {
    
    //MARK: Properties
    
    var alimento: String
    var cantidad: Int
    var tomas: Int
    
    //MARK: Initialization
    
    init(alimento: String, cantidad: Int, tomas: Int) {
        self.alimento = alimento
        self.cantidad = cantidad
        self.tomas = tomas
    }
    
}
