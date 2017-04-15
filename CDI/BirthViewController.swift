//
//  AnimalViewController.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class BirthViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    // MARK: Properties
    var birth: Birth?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var criasMachoTextField: UITextField!
    @IBOutlet weak var criasHembraTextField: UITextField!
    @IBOutlet weak var criasMuertasTextField: UITextField!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var fechaPicker: UIDatePicker!
    
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddAnimalMode = presentingViewController is SWRevealViewController
        
        if (isPresentingInAddAnimalMode){
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The BirthViewController is not inside a navigation controller.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextFields style
        idTextField.underlined()
        criasMachoTextField.underlined()
        criasHembraTextField.underlined()
        criasMuertasTextField.underlined()
        descripcionTextField.underlined()
        
        // Handle the text field’s user input through delegate callbacks.
        idTextField.delegate = self
        
        // Set up views if editing an existing animal.
        if let birth = birth {
            
            navigationItem.title = ""

            idTextField.text = birth.idAnimal
            criasMachoTextField.text = String(birth.criasMacho)
            criasHembraTextField.text = String(birth.criasHembra)
            criasMuertasTextField.text = String(birth.criasMuertas)
            descripcionTextField.text = birth.descripcion
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            fechaPicker.date = dateFormatter.date(from: birth.fecha)!
        }
        
        // Enable the Save button only if the text field has an ID.
        updateSaveButtonState()
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let id = idTextField.text ?? ""
        let criasMacho = Int(criasMachoTextField.text!)
        let criasHembra = Int(criasHembraTextField.text!)
        let criasMuertas = Int(criasMuertasTextField.text!)
        let descripcion = descripcionTextField.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let fecha = dateFormatter.string(from: fechaPicker.date)

        // Set the birth to be passed to BirtTableViewController after the unwind segue.
        birth = Birth(idAnimal: id, criasMacho: criasMacho!, criasHembra: criasHembra!, criasMuertas: criasMuertas!, fecha: fecha, descripcion: descripcion!)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = idTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //MARK: Hide keyboard when user touches outside keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
 

}
