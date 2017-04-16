//
//  Controlador.swift
//  CDI
//
//  Created by ETSISI on 11/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class PestTableViewController: UITableViewController{

    var pests = [Pest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSamplePests()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.tableView.isEditing == true){
            return (self.pests.count + 1)
        }
        else {
            return self.pests.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.tableView.isEditing){
            if(indexPath.row < self.pests.count){
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! PestTableViewCell!
              
                cell?.id.text = pests[indexPath.row].id
                cell?.tipo.text = pests[indexPath.row].tipo
                cell?.fecha.text = pests[indexPath.row].fecha
                
                switch pests[indexPath.row].tipo {
                case "Desinsectación":
                    cell?.imagen.image = UIImage(named: "roach")
                case "Desratización":
                    cell?.imagen.image = UIImage(named: "rat")
                default:
                    cell?.imagen.image = nil
                }
                
                return cell!
            }
            else{
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "addCell") as UITableViewCell!
                cell!.textLabel?.text = "añadir plan"
                return cell!
            }
        }
        else{
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! PestTableViewCell!

            cell?.id.text = pests[indexPath.row].id
            cell?.tipo.text = pests[indexPath.row].tipo
            cell?.fecha.text = pests[indexPath.row].fecha
            
            switch pests[indexPath.row].tipo {
            case "Desinsectación":
                cell?.imagen.image = UIImage(named: "roach")
            case "Desratización":
                cell?.imagen.image = UIImage(named: "rat")
            default:
                break
            }
            return cell!
        }

        
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.row == self.pests.count) {
            return UITableViewCellEditingStyle.insert
        }
        else{
            return UITableViewCellEditingStyle.delete
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // Delete the row from the data source
            self.pests.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
         else if editingStyle == .insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            self.pests.append(Pest(id: "0000", tipo: "-", fecha: "-")!)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            tableView.endUpdates()
     //       tableView.reloadData()
            
         }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? ""){
            
        case "AddItem":
            print("Adding item")
        case "ShowDetail":
            
            guard let pestViewController = segue.destination as? PestViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? PestTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            let indexPath = tableView.indexPathForSelectedRow
            
            pestViewController.pest = pests[indexPath!.row]
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            
        }
    }
    
    // MARK: - Actions
    @IBAction func unwindToPestList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? PestViewController, let pest = sourceViewController.pest {
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                // Update an existing pest.
                pests[selectedIndexPath.row] = pest
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new pest.
                let newIndexPath = IndexPath(row: pests.count, section: 0)
                
                pests.append(pest)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }



    // LOAD Samples
    private func loadSamplePests() {
        let pest1 = Pest(id: "5728", tipo: "Desinsectación", fecha: "16/03/2017")!
        let pest2 = Pest(id: "4158", tipo: "Desratización", fecha: "19/03/2017")!

        pests += [pest1, pest2]
    }
    
    
    
    
}



