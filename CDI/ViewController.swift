//
//  ViewController.swift
//  CDI
//
//  Created by ETSISI on 1/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gestion: UIView!
    @IBOutlet weak var nacimientos: UIView!
    @IBOutlet weak var seguridad: UIView!
    @IBOutlet weak var sanidad: UIView!
    @IBOutlet weak var alimentacion: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gestion.layer.cornerRadius = 12
        nacimientos.layer.cornerRadius = 12
        seguridad.layer.cornerRadius = 12
        sanidad.layer.cornerRadius = 12
        alimentacion.layer.cornerRadius = 12

        gestion.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}



