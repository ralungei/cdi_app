//
//  AnimalViewController.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class PestViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{

    // MARK: Properties
    var pest: Pest?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var planTextField: UITextField!
    @IBOutlet weak var fechaPicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        print(presentingViewController?.title ?? "")

        dismiss(animated: true, completion: nil)

    }
 
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = "Nuevo plan"

        // Handle the text field’s user input through delegate callbacks.
        idTextField.delegate = self
        
        // Set up views if editing an existing animal.
        if let pest = pest {
            
            navigationBar.topItem?.title = pest.id

            idTextField.text = pest.id
            planTextField.text = pest.tipo

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            fechaPicker.date = dateFormatter.date(from: pest.fecha)!
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
        let tipo = planTextField.text ?? ""

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let fecha = dateFormatter.string(from: fechaPicker.date)

        // Set the birth to be passed to BirtTableViewController after the unwind segue.
        pest = Pest(id: id, tipo: tipo, fecha: fecha)
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
