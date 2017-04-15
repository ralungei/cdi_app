//
//  AnimalTabController.swift
//  CDI
//
//  Created by ETSISI on 14/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class AnimalTabController: UITabBarController{
    var animal: Animal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting bar button item
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [editButton, deleteButton]
   //     self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        
    }
}
