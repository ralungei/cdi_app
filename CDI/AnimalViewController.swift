//
//  AnimalViewController.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class AnimalViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Properties
    var animal: Animal?
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var codFamTextField: UITextField!
    @IBOutlet weak var animalTextField: UITextField!
    @IBOutlet weak var pesoTextField: UITextField!
    @IBOutlet weak var razaTextField: UITextField!
    @IBOutlet weak var estadoTextField: UITextField!
    @IBOutlet weak var sexoTextField: UITextField!
    @IBOutlet weak var cuarentenaControl: UISegmentedControl!
    @IBOutlet weak var fechaPicker: UIDatePicker!
    @IBOutlet weak var imagen: UIImageView!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddAnimalMode = presentingViewController is UINavigationController
        
        if (isPresentingInAddAnimalMode){
            os_log("1!", log: OSLog.default, type: .debug)

            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            os_log("2!", log: OSLog.default, type: .debug)

            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    // MARK: Picker view options
    var animalOptions = ["vaca", "cabra", "oveja", "gallina", "conejo", "cerdo"]
    var estadoOptions = ["vacio"]
    var sexoOptions = ["hembra", "varon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextFields style
        idTextField.underlined()
        codFamTextField.underlined()
        animalTextField.underlined()
        pesoTextField.underlined()
        razaTextField.underlined()
        estadoTextField.underlined()
        sexoTextField.underlined()

        
        
        // Handle the text field’s user input through delegate callbacks.
        idTextField.delegate = self
        // Set up views if editing an existing animal.
        if let animal = animal {
            
            navigationItem.title = ""
            let tipo = animal.tipo
            
            idTextField.text = animal.idAnimal
            codFamTextField.text = animal.codFamilia
            animalTextField.text = tipo
            pesoTextField.text = String(animal.peso)
            razaTextField.text = animal.raza
            estadoTextField.text = animal.estado
            sexoTextField .text = animal.sexo
            
            if(animal.cuarentena == false){
                cuarentenaControl.selectedSegmentIndex = 0
            }
            else{
                cuarentenaControl.selectedSegmentIndex = 1
            }
            
            fechaPicker.date = animal.fecha
            
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

        
        // Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonState()
        
        // Pickers
        
        let animalPickerView = UIPickerView()
        animalPickerView.delegate = self
        animalPickerView.tag = 0
        animalTextField.inputView = animalPickerView
        
        let sexoPickerView = UIPickerView()
        sexoPickerView.delegate = self
        sexoPickerView.tag = 1
        sexoTextField.inputView = sexoPickerView
        
        
    }
    
    //MARK: Picker funcs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0){
            return animalOptions.count
        }
        else{
            return sexoOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0){
            return animalOptions[row]
        }
        else{
            return sexoOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0){
            animalTextField.text = animalOptions[row]
        }
        else{
            sexoTextField.text = sexoOptions[row]
        }
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
        let tipo = animalTextField.text ?? ""
        let codFam = codFamTextField.text ?? ""
        let raza = razaTextField.text ?? ""
        let sexo = sexoTextField.text ?? ""
        let fecha = fechaPicker.date
        let peso = Float(pesoTextField.text!) ?? 0.0
        let edad = 0
        let estado = estadoTextField.text ?? ""
        
        let valorCuarentena = cuarentenaControl.selectedSegmentIndex
        let cuarentena: Bool
        if(valorCuarentena == 0){
            cuarentena = false
        }
        else {
            cuarentena = true
        }
        
        // Set the animal to be passed to AnimalTableViewController after the unwind segue.
        
        animal = Animal(idAnimal: id, tipo: tipo, codFamilia: codFam, raza: raza, sexo: sexo, fecha: fecha, peso: peso, edad: edad, estado: estado, cuarentena: cuarentena)
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = idTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
 

}
