//
//  AnimalDetailViewController.swift
//  CDI
//
//  Created by ETSISI on 10/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var codFamLabel: UILabel!
    @IBOutlet weak var razaLabel: UILabel!
    @IBOutlet weak var sexoLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var cuarentenaLabel: UILabel!
    
    var animal: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Label underlines
        codFamLabel.underlined()
        razaLabel.underlined()
        sexoLabel.underlined()
        pesoLabel.underlined()
        estadoLabel.underlined()
        cuarentenaLabel.underlined()
        
        // Asign cell values to labels
        idLabel.text = animal?.idAnimal
        codFamLabel.text = animal?.codFamilia
        razaLabel.text = animal?.raza
        sexoLabel.text = animal?.sexo
        pesoLabel.text = String(animal!.peso)
        estadoLabel.text = animal?.estado
        
        let cuarentenaValue = animal?.cuarentena
        if (cuarentenaValue == true){
            cuarentenaLabel.text = "Si"
        }
        else {
            cuarentenaLabel.text = "No"
        }
        
        let tipo = animal!.tipo
        
        switch tipo {
        case "gallina":
            imagen.image = UIImage(named: "001-cock")
        case "cerdo":
            imagen.image = UIImage(named: "002-pig")
        case "oveja":
            imagen.image = UIImage(named: "003-sheep")
        case "conejo":
            imagen.image = UIImage(named: "004-rabbit")
        case "cabra":
            imagen.image = UIImage(named: "005-goat")
        case "vaca":
            imagen.image = UIImage(named: "006-cow")
        default:
            break
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "Edit" {
            guard let animalEditViewController = segue.destination as? AnimalViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
            animalEditViewController.animal = animal
        }
            
        else{
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")

        }
        
            
    }
        
}


