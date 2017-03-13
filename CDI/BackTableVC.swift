//
//  BackTableVC.swift
//  CDI
//
//  Created by ETSISI on 5/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class BackTableVC: UITableViewController {
    
    var TableArray = [String]()
    
    
    override func viewDidLoad() {
        TableArray = ["Gestión","Nacimientos","Alimentación", "Sanidad", "Seguridad"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
    
}