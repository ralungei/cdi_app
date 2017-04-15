//
//  ManagementTableViewController.swift
//  CDI
//
//  Created by ETSISI on 7/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class BirthsTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBAction func deleteAction(_ sender: Any) {
        if isEditing == true{
            deleteButton.image = UIImage(named: "trash")
            deleteButton.title = nil
            setEditing(false, animated: true)
        }
        else{
            setEditing(true, animated: true)
            deleteButton.image = nil
            deleteButton.title = "OK"
        }
    }
    var births = [Birth]()
    var filteredBirths = [Birth]()
    
    var animals = [Animal]()
    
    let searchController = UISearchController(searchResultsController: nil)

    let userCalendar = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchBar.keyboardType = UIKeyboardType.numberPad
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.init(red: 0.909, green: 0.27, blue: 0.235, alpha: 1)
        searchController.searchBar.backgroundColor = UIColor.init(red: 0.909, green: 0.27, blue: 0.235, alpha: 1)
        searchController.searchBar.backgroundImage = UIImage()

        // Setup the menu
        if (self.revealViewController() != nil){
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }


        // Load the sample data
        /* Uncomment to load from array
        loadSampleBirths()
        */
        // Load from file
        parseCSV()
        parseCSVManagement()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Table view
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return self.filteredBirths.count
        }
        else {
            return self.births.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as? BirthsTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of BirthsTableViewCell.")
        }

        var arrayBirths = [Birth]()
        
        if searchController.isActive {
            arrayBirths = self.filteredBirths
        }
        else{
            arrayBirths = self.births
        }
        
        let birth = arrayBirths[indexPath.row]
        
        cell.idAnimal.text = birth.idAnimal
        cell.fecha.text = birth.fecha
        
        let animal = animals[Int(birth.idAnimal)!]
        // TENGO QUE COGER LOS DATOS DEL ANIMAL CORRESPONDIENTE BUSCANDOLO POR ID
        switch animal.tipo {
            case "gallina":
                cell.imagen.image = UIImage(named: "chicken")
            case "cerdo":
                cell.imagen.image = UIImage(named: "pig")
            case "oveja":
                cell.imagen.image = UIImage(named: "sheep")
            case "conejo":
                cell.imagen.image = UIImage(named: "rabbit")
            case "cabra":
                cell.imagen.image = UIImage(named: "deer")
            case "vaca":
                cell.imagen.image = UIImage(named: "cow")
            default:
                break
        }
        
        return cell
    }

    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
    
    func deleteRow(forRowAt indexPath: IndexPath){
        // Delete the row from the data source
        if(self.searchController.isActive){
            let idAnimalBusqueda = self.filteredBirths[indexPath.row].idAnimal
            let indexTableview = self.births.index(where: { (birth) -> Bool in
                birth.idAnimal == idAnimalBusqueda
            })
            self.filteredBirths.remove(at: indexPath.row)
            
            // Delete the birth from the original array of births
            self.births.remove(at: indexTableview!)
        }
        else{
            self.births.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Confirmation alert
        let deleteConfirmation = UIAlertController.init(title: nil, message: "¿Desea eliminar la fila seleccionada?", preferredStyle: .actionSheet)
                
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {(alert: UIAlertAction!) -> Void in
            self.deleteRow(forRowAt: indexPath)
        })
                
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
                
        deleteConfirmation.addAction(okAction)
        deleteConfirmation.addAction(cancelAction)

        deleteConfirmation.popoverPresentationController?.sourceView = self.view
        deleteConfirmation.popoverPresentationController?.sourceRect = self.tableView.rectForRow(at: indexPath)
        self.present(deleteConfirmation, animated: true, completion: nil)
        }
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? ""){
            
            case "AddItem":
                os_log("Adding a new birth.", log: OSLog.default, type: .debug)
        
            case "ShowDetail":
                
                guard let birthDetailViewController = segue.destination as? BirthDetailViewController
                    else {
                        fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let selectedBirthCell = sender as? BirthsTableViewCell else {
                    fatalError("Unexpected sender: \(sender)")
                }
                
                let indexPath = tableView.indexPathForSelectedRow
                let birth: Birth?
                
                if searchController.isActive {
                    birth = filteredBirths[(indexPath!.row)]
                    birthDetailViewController.birth = birth
                }
            
                else {
                    birth = births[(indexPath?.row)!]
                    birthDetailViewController.birth = birth
                }
            
            birthDetailViewController.animal = animals[Int((birth?.idAnimal)!)!]
        
            
        /*
                // MARK: Selected cell doesn't belong to the displayed tableView
                guard let indexPath = tableView.indexPath(for: selectedBirthCell) else{
                    fatalError("The selected cell is not being displayed by the table")
                }
        */
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")

        }
     }
    
    // MARK: - Actions
    @IBAction func unwindToBirthList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? BirthViewController, let birth = sourceViewController.birth {
            
            if self.searchController.isActive {
                fatalError("SEARCH DISPLAY CONTROLLER IS STILL ACTIVE;")
            }
            else {
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                // Update an existing birth.
                births[selectedIndexPath.row] = birth
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else {
                // Add a new birth.
                let newIndexPath = IndexPath(row: births.count, section: 0)
                
                births.append(birth)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
        else if sender.source is BirthDetailViewController {
            deleteRow(forRowAt: tableView.indexPathForSelectedRow!)
        }
    }
    
    
    
    // MARK: - Search
    func filterContentForSearchText(_ searchText: String, scope: String = "Todos") {
        self.filteredBirths = self.births.filter({( birth: Birth) -> Bool in
            if(searchController.searchBar.text == ""){
                return true
            }
            else{
                return birth.idAnimal.contains(searchText)
            }
        })
        tableView.reloadData()
    }
    
    

    /*
    // MARK: - Device Orientation
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
     */
    
    // MARK: - Data
    
    private func loadSampleBirths() {
        let birth1 = Birth(idAnimal: "0001", criasMacho: 2, criasHembra: 3, criasMuertas: 4, fecha: "12/12/1996", descripcion: "descripcion")
        
        let birth2 = Birth(idAnimal: "9124", criasMacho: 2, criasHembra: 1, criasMuertas: 1, fecha: "12/12/1996", descripcion: "descripcion")

        births += [birth1, birth2]
    }
    
    private func parseCSV() {
        let path = Bundle.main.path(forResource: "birthsData", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let birth = Birth(idAnimal: row["idAnimal"]!, criasMacho: Int(row["criasMacho"]!)!, criasHembra: Int(row["criasHembra"]!)!, criasMuertas: Int(row["criasMuertas"]!)!, fecha: row["fecha"]!, descripcion: row["descripcion"]!)
                
                births.append(birth)
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    
    private func parseCSVManagement() {
        let path = Bundle.main.path(forResource: "data", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let animal = Animal(idAnimal: row["idAnimal"]!, tipo: row["tipo"]!, codFamilia: row["codFamilia"]!, raza: row["raza"]!, sexo: row["sexo"]!, fecha: row["fecha"]!, peso: Float(row["peso"]!)!, estado: row["estado"]!, cuarentena: Bool(row["cuarentena"]!)!)
                
                animals.append(animal!)
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
}





