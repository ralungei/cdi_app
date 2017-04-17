//
//  ProductsTableViewController.swift
//  CDI
//
//  Created by ETSISI on 17/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController{
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleProducts()
        
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
            return self.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell!
                
            cell?.id.text = products[indexPath.row].id
            cell?.nombre.text = products[indexPath.row].nombre
            cell?.fecha.text = products[indexPath.row].fecha
                
            return cell!
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? ""){
            
        case "AddItem":
            print("Adding item")
        case "ShowDetail":
            
            guard let productViewController = segue.destination as? ProductViewController
                else {
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? ProductTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            let indexPath = tableView.indexPathForSelectedRow
            
            productViewController.product = products[indexPath!.row]
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            
        }
    }
    
    // MARK: - Actions
    @IBAction func unwindToProductsList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? ProductViewController, let product = sourceViewController.product {
            if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                // Update an existing product.
                products[selectedIndexPath.row] = product
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new product.
                let newIndexPath = IndexPath(row: products.count, section: 0)
                
                products.append(product)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    
    // LOAD Samples
    private func loadSampleProducts() {
        let product1 = Product(id: "5728", nombre: "Clorin", fecha: "16/03/2017")!
        let product2 = Product(id: "4158", nombre: "Neutrexol", fecha: "19/03/2017")!
        let product3 = Product(id: "6263", nombre: "Orofilm", fecha: "21/06/2017")!

        products += [product1, product2, product3]
    }
    
    
    
    
}
