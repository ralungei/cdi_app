//
//  FeedingViewController.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class FeedingViewController: UIViewController {

    // MARK: Properties
    
    var feeding: Feeding?
    
    var tipoSegue = ""
    var estadoSegue = ""
    
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var cantidadTextField: UITextField!
    @IBOutlet weak var tomasTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreTextField.underlined()
        cantidadTextField.underlined()
        tomasTextField.underlined()
        
        tipo.text = tipoSegue
        estado.text = estadoSegue
        
        if let feeding = feeding {
            nombreTextField.text = feeding.alimento
            cantidadTextField.text = "\(feeding.cantidad)"
            tomasTextField.text = "\(feeding.tomas)"
        }
    
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            print("ERROR SAVE BUTTON")
            return
        }
        
        let nombre = nombreTextField.text!
        let cantidad = cantidadTextField.text!
        let tomas = tomasTextField.text!
        
        print("He llegado aqui")
        print(nombre)
        print(cantidad)
        print(tomas)
        
        // Set the feeding to be passed to FeedingTableViewController after the unwind segue.
        feeding = Feeding(alimento: nombre, cantidad: Int(cantidad)!, tomas: Int(tomas)!)

    }



    


}
