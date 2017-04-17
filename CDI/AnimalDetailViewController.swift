//
//  AnimalDetailViewController.swift
//  CDI
//
//  Created by ETSISI on 10/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var codFamLabel: UILabel!
    @IBOutlet weak var razaLabel: UILabel!
    @IBOutlet weak var sexoLabel: UILabel!
    @IBOutlet weak var pesoLabel: UILabel!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var cuarentenaLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var edadLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!

    @IBAction func deleteAction(_ sender: Any) {
        // Confirmation alert
        let deleteConfirmation = UIAlertController.init(title: nil, message: "Seleccione el motivo de la baja.", preferredStyle: .alert)
        
        let soldAction = UIAlertAction(title: "Venta", style: .destructive, handler: {(action)  in
            self.performSegue(withIdentifier: "unwindToAnimalList", sender: self)
        })
        
        let deadAction = UIAlertAction(title: "Fallecimiento", style: .destructive, handler: {(alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "unwindToAnimalList", sender: self)
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
        
        deleteConfirmation.addAction(soldAction)
        deleteConfirmation.addAction(deadAction)
        deleteConfirmation.addAction(cancelAction)
        
        deleteConfirmation.popoverPresentationController?.sourceView = self.view
        deleteConfirmation.popoverPresentationController?.sourceRect = self.deleteButton.accessibilityFrame

        self.present(deleteConfirmation, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var pillsTableView: UITableView!
    @IBOutlet weak var vaccinesTableView: UITableView!
    
    var animal: Animal?
    var pills = [Pill]()
    var vaccines = [Vaccine]()
    
    let calendar = NSCalendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting table views
        pillsTableView.delegate = self
        pillsTableView.dataSource = self

        vaccinesTableView.delegate = self
        vaccinesTableView.dataSource = self

        pillsTableView.tableFooterView = UIView()
        vaccinesTableView.tableFooterView = UIView()
        
        // Label underlines
        codFamLabel.underlined()
        razaLabel.underlined()
        sexoLabel.underlined()
        pesoLabel.underlined()
        estadoLabel.underlined()
        cuarentenaLabel.underlined()
        fechaLabel.underlined()
        edadLabel.underlined()
        
        // Asign cell values to labels
        idLabel.text = animal?.idAnimal
        codFamLabel.text = animal?.codFamilia
        razaLabel.text = animal?.raza
        sexoLabel.text = animal?.sexo
        pesoLabel.text = String(animal!.peso)
        estadoLabel.text = animal?.estado
        tipoLabel.text = animal?.tipo
        fechaLabel.text = animal?.fecha
        
        // Setting 'edad'
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let fecha = dateFormatter.date(from: (animal?.fecha)!)
        
        let diferenciaEdad = Calendar.current.dateComponents([.year, .month, .day], from: fecha!, to: Date())
        
        let years = diferenciaEdad.year!
        let months = diferenciaEdad.month!
        let days = diferenciaEdad.day!
        
        edadLabel.text = "\(years)a " + "\(months)m " + "\(days)d"

        //  Setting 'cuarentena'
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
        
        
        // LOAD DATA
        loadSampleData()
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
        else if segue.identifier == "unwindToAnimalList" {
            // Save the removal reason
       }
        else{
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.pillsTableView{
            count = pills.count
        }
        else if tableView == self.vaccinesTableView {
            count = vaccines.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.pillsTableView{
            let cell = self.pillsTableView.dequeueReusableCell(withIdentifier: "cell") as! PillTableViewCell!
            
            cell?.id.text = pills[indexPath.row].id
            cell?.nombre.text = pills[indexPath.row].nombre
            cell?.dosis.text = pills[indexPath.row].dosis
            cell?.toma.text = pills[indexPath.row].toma
            cell?.fechaInicio.text = pills[indexPath.row].fechaInicio
            cell?.fechaFin.text = pills[indexPath.row].fechaFin
            return cell!
        }
            
        else if tableView == self.vaccinesTableView {
            let cell = self.vaccinesTableView.dequeueReusableCell(withIdentifier: "cell") as! VaccineTableViewCell!
            
            cell?.id.text = vaccines[indexPath.row].id
            cell?.nombre.text = vaccines[indexPath.row].nombre
            cell?.fecha.text = vaccines[indexPath.row].fecha
            return cell!
        }
        return UITableViewCell()
    }

    
    // MARK: - Data
    
    private func loadSampleData() {
        let pill1 = Pill(id: "2742", nombre: "Dipirona", dosis: "20 ml", toma: "1/2", fechaInicio: "17/04/2017", fechaFin: "21/04/2017")!
        let pill2 = Pill(id: "3342", nombre: "Tylogent", dosis: "10 ml", toma: "2", fechaInicio: "18/06/2017", fechaFin: "31/04/2017")!

        
        let vaccine1 = Vaccine(id: "1525", nombre: "Derrienfe", fecha: "23/01/2017")!
        let vaccine2 = Vaccine(id: "8148", nombre: "Silvet VAC", fecha: "24/02/2017")!
        
        pills += [pill1, pill2]
        vaccines += [vaccine1, vaccine2]
    }
    
    
    
    
    
}


