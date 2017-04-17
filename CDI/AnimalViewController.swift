//
//  AnimalViewController.swift
//  CDI
//
//  Created by ETSISI on 9/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class AnimalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Properties
    
    @IBOutlet weak var medicamentosTableView: UITableView!
    @IBOutlet weak var vacunasTableView: UITableView!
    
    var animal: Animal?
    var vaccines = [Vaccine]()
    var pills = [Pill]()
    
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

    @IBAction func animalAction(_ sender: UITextField) {
        switch animalTextField.text! {
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
            imagen.image = UIImage(named: "")
        }
    }
    
    
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
            fatalError("The AnimalViewController is not inside a navigation controller.")
        }
    }
    
    // MARK: Picker view options
    var animalOptions = ["vaca", "cabra", "oveja", "gallina", "conejo", "cerdo"]
    var estadoOptions = ["sano", "enfermo", "gestación", "lactante", "celo"]
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
            
            // Data
            loadSampleData()
            
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
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            fechaPicker.date = dateFormatter.date(from: animal.fecha)!
            
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
        
        // Enable the Save button only if the text field has an ID.
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
        
        let estadoPickerView = UIPickerView()
        estadoPickerView.delegate = self
        estadoPickerView.tag = 2
        estadoTextField.inputView = estadoPickerView
        
        
        // Setting tableviews
        self.medicamentosTableView.delegate = self
        self.vacunasTableView.delegate = self
        
        self.medicamentosTableView.dataSource = self
        self.vacunasTableView.dataSource = self
        
        self.medicamentosTableView.setEditing(true, animated: true)
        self.vacunasTableView.setEditing(true, animated: true)
        
        self.medicamentosTableView.tableFooterView = UIView()
        self.vacunasTableView.tableFooterView = UIView()
    }
    
    //MARK: Picker funcs
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0){
            return animalOptions.count
        }
        else if (pickerView.tag == 1){
            return sexoOptions.count
        }
        
        else if (pickerView.tag == 2){
            return estadoOptions.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0){
            return animalOptions[row]
        }
        else if (pickerView.tag == 1){
            return sexoOptions[row]
        }
        else if (pickerView.tag == 2){
            return estadoOptions[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0){
            animalTextField.text = animalOptions[row]
        }
        else if (pickerView.tag == 1){
            sexoTextField.text = sexoOptions[row]
        }
        else if (pickerView.tag == 2){
            estadoTextField.text = estadoOptions[row]
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
        let peso = Float(pesoTextField.text!) ?? 0.0
        let estado = estadoTextField.text ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let fecha = dateFormatter.string(from: fechaPicker.date)
        
        let valorCuarentena = cuarentenaControl.selectedSegmentIndex
        let cuarentena: Bool
        if(valorCuarentena == 0){
            cuarentena = false
        }
        else {
            cuarentena = true
        }
        
        // Set the animal to be passed to AnimalTableViewController after the unwind segue.
        
        animal = Animal(idAnimal: id, tipo: tipo, codFamilia: codFam, raza: raza, sexo: sexo, fecha: fecha, peso: peso, estado: estado, cuarentena: cuarentena)
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
    
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == medicamentosTableView{
            return (self.pills.count + 1)

        }
        else if tableView == vacunasTableView{
            return (self.vaccines.count + 1)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == medicamentosTableView{
            if(indexPath.row < self.pills.count){
                let cell = self.medicamentosTableView.dequeueReusableCell(withIdentifier: "cell") as! PillInputTableViewCell!
                
                cell?.id.text = pills[indexPath.row].id
                cell?.nombre.text = pills[indexPath.row].nombre
                cell?.dosis.text = pills[indexPath.row].dosis
                cell?.fechaInicio.text = pills[indexPath.row].fechaInicio
                cell?.fechaFin.text = pills[indexPath.row].fechaFin
                
                return cell!
            }
            else{
                let cell = self.vacunasTableView.dequeueReusableCell(withIdentifier: "finalCell") as UITableViewCell!
                cell!.textLabel?.text = "añadir medicamento"
                return cell!
            }
        }
            
        else if tableView == vacunasTableView{
            if(indexPath.row < self.vaccines.count){
                let cell = self.vacunasTableView.dequeueReusableCell(withIdentifier: "cell") as! VaccineInputTableViewCell!
                cell?.id.text = vaccines[indexPath.row].id
                cell?.nombre.text = vaccines[indexPath.row].nombre
                cell?.fecha.text = vaccines[indexPath.row].fecha
                
                return cell!
            }
            else{
                let cell = self.vacunasTableView.dequeueReusableCell(withIdentifier: "finalCell") as UITableViewCell!
                cell!.textLabel?.text = "añadir vacuna"
                return cell!
            }
        }
        
        return UITableViewCell()
    }
    

    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView == medicamentosTableView{
            if (indexPath.row == self.pills.count) {
                return UITableViewCellEditingStyle.insert
            }
            else{
                return UITableViewCellEditingStyle.delete
            }
        }
        else if tableView == vacunasTableView{
            if (indexPath.row == self.vaccines.count) {
                return UITableViewCellEditingStyle.insert
            }
            else{
                return UITableViewCellEditingStyle.delete
            }
        }
        
        return UITableViewCellEditingStyle.insert
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if tableView == medicamentosTableView{
                self.pills.remove(at: indexPath.row)
            }
            else if tableView == vacunasTableView{
                self.vaccines.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            
            if tableView == medicamentosTableView{
                self.pills.append(Pill(id: "", nombre: "", dosis: "", toma: "", fechaInicio: "", fechaFin: "")!)
            }
            else if tableView == vacunasTableView{
                self.vaccines.append(Vaccine(id: "", nombre: "", fecha: "")!)
            }
            

            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            tableView.endUpdates()
            //       tableView.reloadData()
            
        }
    }
    
    //MARK: Data
    private func loadSampleData() {
        let pill1 = Pill(id: "2742", nombre: "Dipirona", dosis: "20 ml", toma: "1/2", fechaInicio: "17/04/2017", fechaFin: "21/04/2017")!
        let pill2 = Pill(id: "3342", nombre: "Tylogent", dosis: "10 ml", toma: "2", fechaInicio: "18/06/2017", fechaFin: "31/04/2017")!
        
        
        let vaccine1 = Vaccine(id: "1525", nombre: "Derrienfe", fecha: "23/01/2017")!
        let vaccine2 = Vaccine(id: "8148", nombre: "Silvet VAC", fecha: "24/02/2017")!
        
        pills += [pill1, pill2]
        vaccines += [vaccine1, vaccine2]
    }
 

}
