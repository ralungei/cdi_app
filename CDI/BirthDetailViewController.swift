//
//  AnimalDetailViewController.swift
//  CDI
//
//  Created by ETSISI on 10/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class BirthDetailViewController: UIViewController {

    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var idAnimal: UILabel!
    @IBOutlet weak var criasMacho: UILabel!
    @IBOutlet weak var criasHembra: UILabel!
    @IBOutlet weak var criasMuertas: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func deleteAction(_ sender: Any) {
        // Confirmation alert
        let deleteConfirmation = UIAlertController.init(title: nil, message: "¿Desea eliminar la fila seleccionada?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {(alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "unwindToBirthsList", sender: self)
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
        
        deleteConfirmation.addAction(okAction)
        deleteConfirmation.addAction(cancelAction)
        
        deleteConfirmation.popoverPresentationController?.sourceView = self.view
        deleteConfirmation.popoverPresentationController?.sourceRect = self.deleteButton.accessibilityFrame
        self.present(deleteConfirmation, animated: true, completion: nil)
    }
    
    
    var birth: Birth?
    var animal: Animal?
    
    let calendar = NSCalendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label underlines
        criasMacho.underlined()
        criasHembra.underlined()
        criasMuertas.underlined()
        fecha.underlined()
        descripcion.underlined()
        
        // Asign cell values to labels
        idAnimal.text = birth?.idAnimal
        criasMacho.text = String(describing: birth!.criasMacho)
        criasHembra.text = String(describing: birth!.criasHembra)
        criasMuertas.text = String(describing: birth!.criasMuertas)
        fecha.text = birth?.fecha
        descripcion.text = birth?.descripcion
        
        switch animal!.tipo {
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
            guard let birthEditViewController = segue.destination as? BirthViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            birthEditViewController.birth = birth
        }
        else if segue.identifier == "unwindToBirthsList" {
            // Save the removal reason
       }
        else{
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
}


