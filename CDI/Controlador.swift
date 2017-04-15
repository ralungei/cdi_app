//
//  Controlador.swift
//  CDI
//
//  Created by ETSISI on 11/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class Controlador: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var vaccines = [Vaccine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadSampleVaccines()
        
        tableView.setEditing(true, animated: true)
        self.tableView.tableFooterView = UIView()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.vaccines.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row < self.vaccines.count){
            let cell1 = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! VaccineTableViewCell!
            cell1?.nombre.text = vaccines[indexPath.row].nombre
            cell1?.fecha.text = vaccines[indexPath.row].fecha
            
            return cell1!
        }
        else{
            let cell2 = self.tableView.dequeueReusableCell(withIdentifier: "finalCell") as UITableViewCell!
            cell2!.textLabel?.text = "añadir vacuna"
            return cell2!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.row == self.vaccines.count) {
            return UITableViewCellEditingStyle.insert
        }
        else{
            return UITableViewCellEditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // Delete the row from the data source
            self.vaccines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
         else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            self.vaccines.append(Vaccine(nombre: "", fecha: "", dosis: "")!)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            tableView.endUpdates()
     //       tableView.reloadData()
            
         }
    }
    
    
    // LOAD Samples
    private func loadSampleVaccines() {
        guard let vaccine1 = Vaccine(nombre: "Vacuna1", fecha: "12/12/1996", dosis: "3 mg")
            else {
                fatalError("Unable to instantiate vaccine1")
        }
        guard let vaccine2 = Vaccine(nombre: "Vacuna2", fecha: "12/12/2000", dosis: "6 mg")
            else {
                fatalError("Unable to instantiate vaccine1")
        }
        vaccines += [vaccine1, vaccine2]
    }
    
    
    
    
}



