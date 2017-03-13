//
//  ViewController.swift
//  CDI
//
//  Created by ETSISI on 1/3/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gestion: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gestion.layer.cornerRadius = 12
        gestion.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}



