//
//  ManagementTableViewController.swift
//  CDI
//
//  Created by ETSISI on 7/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import os.log

class ManagementTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
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
    var animals = [Animal]()
    var filteredAnimals = [Animal]()
    
    let searchController = UISearchController(searchResultsController: nil)

    let userCalendar = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchBar.keyboardType = UIKeyboardType.numberPad
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.selectedScopeButtonIndex = 0
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.init(red: 0.909, green: 0.27, blue: 0.235, alpha: 1)
        searchController.searchBar.backgroundColor = UIColor.init(red: 0.909, green: 0.27, blue: 0.235, alpha: 1)
        searchController.searchBar.backgroundImage = UIImage()

        // Setup the Scope Bar
        searchController.searchBar.scopeButtonTitles = ["Todos", "Bovino", "Porcino", "Ovino", "Caprino", "Conejos", "Aves"]
        tableView.tableHeaderView = searchController.searchBar

        
        // Setup the menu
        if (self.revealViewController() != nil){
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
        }
        

        // Load the sample data
        /* Uncomment to load from array
        loadSampleAnimals()
        */
        // Load from file
        parseCSV()
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
            return self.filteredAnimals.count
        }
        else {
            return self.animals.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as? ManagementTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of ManagementTableViewCell.")
        }

        var arrayAnimals = [Animal]()
        
        if searchController.isActive {
            arrayAnimals = self.filteredAnimals
        }
        else{
            arrayAnimals = self.animals
        }
        
        let animal = arrayAnimals[indexPath.row]
        cell.id.text = animal.idAnimal
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
        
        switch animal.sexo {
            case "hembra":
                cell.sexo.image = UIImage(named: "female")
            case "varon":
                cell.sexo.image = UIImage(named: "male")
            default:
            break
        }
        
        cell.fecha.text = animal.fecha

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
            let idAnimalBusqueda = self.filteredAnimals[indexPath.row].idAnimal
            let indexTableview = self.animals.index(where: { (animal) -> Bool in
                animal.idAnimal == idAnimalBusqueda
            })
            self.filteredAnimals.remove(at: indexPath.row)
            
            // Delete the animal from the original array of animals
            self.animals.remove(at: indexTableview!)
        }
        else{
            self.animals.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Confirmation alert
        let deleteConfirmation = UIAlertController.init(title: nil, message: "Seleccione el motivo de la baja.", preferredStyle: .actionSheet)
        
        
        let soldAction = UIAlertAction(title: "Venta", style: .destructive, handler: {(action)  in
            self.deleteRow(forRowAt: indexPath)
        
        })
                
        let deadAction = UIAlertAction(title: "Fallecimiento", style: .destructive, handler: {(alert: UIAlertAction!) -> Void in
            self.deleteRow(forRowAt: indexPath)
        })
                
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
                
        deleteConfirmation.addAction(soldAction)
        deleteConfirmation.addAction(deadAction)
        deleteConfirmation.addAction(cancelAction)

        deleteConfirmation.popoverPresentationController?.sourceView = self.view
        deleteConfirmation.popoverPresentationController?.sourceRect = self.tableView.rectForRow(at: indexPath)
        self.present(deleteConfirmation, animated: true, completion: nil)
     }
        /* else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        */
    }
    
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
                
                let indexPath = tableView.indexPathForSelectedRow
                
                if searchController.isActive {
                    if indexPath != nil {
                        animalDetailViewController.animal = filteredAnimals[(indexPath!.row)]
                    }
                    else {
                        animalDetailViewController.animal = animals[indexPath!.row]
                    }
                }
            
                else {
                    if indexPath != nil {
                        animalDetailViewController.animal = animals[(indexPath?.row)!]
                    }
                    
            }
            
        /*
                // MARK: Selected cell doesn't belong to the displayed tableView
                guard let indexPath = tableView.indexPath(for: selectedAnimalCell) else{
                    fatalError("The selected cell is not being displayed by the table")
                }
        */
            default:
                fatalError("Unexpected Segue Identifier; \(segue.identifier)")

        }
     }
    
    // MARK: - Actions
    @IBAction func unwindToAnimalList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? AnimalViewController, let animal = sourceViewController.animal {
            
            if self.searchController.isActive {
                self.searchController.isActive = false
            }

                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                // Update an existing animal.
                animals[selectedIndexPath.row] = animal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
                else {
                // Add a new animal.
                let newIndexPath = IndexPath(row: animals.count, section: 0)
                
                animals.append(animal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            
        }
        else if sender.source is AnimalDetailViewController {
            deleteRow(forRowAt: tableView.indexPathForSelectedRow!)
        }
    }
    
    
    
    // MARK: - Search
    func filterContentForSearchText(_ searchText: String, scope: String = "Todos") {
        self.filteredAnimals = self.animals.filter({( animal: Animal) -> Bool in
            let tipo: String
            
            switch animal.tipo {
            case "vaca":
                tipo = "Bovino"
            case "cerdo":
                tipo = "Porcino"
            case "oveja":
                tipo = "Ovino"
            case "cabra":
                tipo = "Caprino"
            case "conejo":
                tipo = "Conejos"
            case "gallina":
                tipo = "Aves"
            default:
                tipo = ""
            }
            
            let tipoMatch = (scope == "Todos") || (tipo == scope)
            
            if(searchController.searchBar.text == ""){
                return tipoMatch
            }
            else{
                return tipoMatch && animal.idAnimal.contains(searchText)
            }
            //String(animal.idAnimal)?.range(of: searchText) != nil
            })
        tableView.reloadData()
    }
    

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
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
    
    private func loadSampleAnimals() {
        guard let animal1 = Animal(idAnimal: "0001", tipo: "vaca", codFamilia: "0001", raza: "holstein", sexo: "hembra", fecha: "12/12/1996", peso: 606, estado: "lLactante", cuarentena: true)
            else {
                fatalError("Unable to instantiate animal1")
        }
        
        guard let animal2 = Animal(idAnimal: "0002", tipo: "conejo", codFamilia: "0001", raza: "holstein", sexo: "varon", fecha: "12/12/1996", peso: 645, estado: "lactante", cuarentena: false)
            else {
                fatalError("Unable to instantiate animal2")
        }
        animals += [animal1, animal2]
    }
    
    private func parseCSV() {
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





