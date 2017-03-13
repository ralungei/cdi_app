//
//  ManagementTableViewController.swift
//  CDI
//
//  Created by ETSISI on 7/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

let userCalendar = Calendar.current

class ManagementTableViewController: UITableViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var animals = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Load the sample data
        loadSampleAnimals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ManagementTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of ManagementTableViewCell.")
        }

        let animal = animals[indexPath.row]
        
        cell.id.text = animal.idAnimal
        switch animal.tipo {
            case "gallina":
                cell.imagen.image = UIImage(named: "001-cock")
            case "cerdo":
                cell.imagen.image = UIImage(named: "002-pig")
            case "oveja":
                cell.imagen.image = UIImage(named: "003-sheep")
            case "conejo":
                cell.imagen.image = UIImage(named: "004-rabbit")
            case "cabra":
                cell.imagen.image = UIImage(named: "005-goat")
            case "vaca":
                cell.imagen.image = UIImage(named: "006-cow")
            default:
                break
        }
        cell.sexo.text = animal.sexo
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        let fechaString = dateformatter.string(from: animal.fecha)
        cell.fecha.text = fechaString


        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? ""){
            case "AddItem":
            os_log("Adding a new animal.", log: OSLog.default, type: .debug)
        
            case "ShowDetail":
            guard let animalDetailViewController = segue.destination as? AnimalDetailViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedAnimalCell = sender as? ManagementTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAnimalCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedAnimal = animals[indexPath.row]
            animalDetailViewController.animal = selectedAnimal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")

        
        }
        
     }
    
    
    
    // MARK: - Actions
    
    @IBAction func unwindToAnimalList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as?
            AnimalViewController, let animal = sourceViewController.animal {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: animals.count, section: 0)
            
            animals.append(animal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    

    
    // Orientation
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    // MARK: - Data
    
    private func loadSampleAnimals() {
        
        var fechaComp = DateComponents()
        fechaComp.year = 2017
        fechaComp.month = 02
        fechaComp.day = 15
        
        let fecha = userCalendar.date(from: fechaComp)
        
        
        guard let animal1 = Animal(idAnimal: "0001", tipo: "vaca", codFamilia: "0001", raza: "Holstein", sexo: "Hembra", fecha: fecha!, peso: 606, edad: 11, estado: "Lactante", cuarentena: true)
            else {
                fatalError("Unable to instantiate animal1")
        }
        
        guard let animal2 = Animal(idAnimal: "0002", tipo: "conejo", codFamilia: "0001", raza: "Holstein", sexo: "Varon", fecha: fecha!, peso: 645, edad: 11, estado: "Lactante", cuarentena: false)
            else {
                fatalError("Unable to instantiate animal2")
        }
        
        animals += [animal1, animal2]
        
    }
    



}
