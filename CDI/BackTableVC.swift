//
//  BackTableVC.swift
//  CDI
//
//  Created by ETSISI on 5/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class BackTableVC: UITableViewController {
    
    @IBOutlet weak var imagen: UIImageView!
    
    var TableArray = [String]()
        
    override func viewDidLoad() {
        TableArray = ["Animales", "Alimentación","Nacimientos","Seguridad"]
        
        self.tableView.tableFooterView = UIView()
  //      tableView.backgroundView = UIImageView(image: UIImage(named: "menu_background"))

    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            imagen.image = UIImage(named: "red")
        case 1:
            imagen.image = UIImage(named: "green")
        case 2:
            imagen.image = UIImage(named: "yellow")
        case 3:
            imagen.image = UIImage(named: "blue")
        default:
            imagen.image = UIImage(named: "red")

            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath) as UITableViewCell
        
        /*
        cell.textLabel?.text = TableArray[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        */
        
//        cell.backgroundColor = UIColor.clear

        return cell
    }
    
    
}
