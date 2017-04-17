//
//  FeedingTableViewController.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class FeedingTableViewController: UITableViewController {

    var feedings = [[Feeding]]()

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var tipos = ["Bovino", "Ovino", "Porcino", "Caprino", "Conejos", "Aves"]
    var estados = ["Sano", "Enfermo", "Gestación", "Lactante", "Celo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the menu
        if (self.revealViewController() != nil){
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        loadSampleFeedings()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.isOpaque = true
        view.tintColor = UIColor.init(red: 0.26, green: 0.764, blue: 0.396, alpha: 1)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tipos[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return estados.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedingTableViewCell

        cell.estado.text = estados[indexPath.row]
        
        cell.alimento.text = feedings[indexPath.section][indexPath.row].alimento
        cell.cantidad.text = "\(feedings[indexPath.section][indexPath.row].cantidad) kg"
        cell.tomas.text = "\(feedings[indexPath.section][indexPath.row].tomas) dia"

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let navigationViewController = segue.destination as? UINavigationController
            else {
                fatalError("Unexpected destination: \(segue.destination)")
        }
        
        let feedingViewController = navigationViewController.viewControllers.first as! FeedingViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        
        feedingViewController.feeding = feedings[indexPath.section][indexPath.row]
        
        feedingViewController.tipoSegue = tipos[indexPath.section]
        feedingViewController.estadoSegue = estados[indexPath.row]

    }
    
    @IBAction func unwindToFeedingList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? FeedingViewController, let feeding = sourceViewController.feeding{
            
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    // Update an existing feeding.
                    feedings[selectedIndexPath.section][selectedIndexPath.row] = feeding

                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
        }
    }
    
    
    func loadSampleFeedings() {
        let feeding1 = Feeding(alimento: "fatina", cantidad: 2, tomas: 3)
        let feeding2 = Feeding(alimento: "rumina", cantidad: 3, tomas: 3)
        let feeding3 = Feeding(alimento: "pasturina", cantidad: 2, tomas: 4)
        let feeding4 = Feeding(alimento: "becerrina", cantidad: 2, tomas: 1)
        let feeding5 = Feeding(alimento: "prt", cantidad: 3, tomas: 3)

        let feeding = [feeding1, feeding2, feeding3, feeding4, feeding5]
        for _ in 1...6{
            feedings.append(feeding)
        }

    }

}
