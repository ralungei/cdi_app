//
//  TemperatureViewController.swift
//  CDI
//
//  Created by ETSISI on 16/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var temperatura: UILabel!
    @IBOutlet weak var humedad: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.selectedItem = tabBar.items?[0]

        self.tabBar.delegate = self
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
        switch(item.tag){
        case 0:
            temperatura.text = "19ºC"
            humedad.text = "52%"
        case 1:
            temperatura.text = "20ºC"
            humedad.text = "55%"
        case 2:
            temperatura.text = "18ºC"
            humedad.text = "54%"
        case 3:
            temperatura.text = "18ºC"
            humedad.text = "54%"
        case 4:
            temperatura.text = "19ºC"
            humedad.text = "56%"
        case 5:
            temperatura.text = "20ºC"
            humedad.text = "55%"
        default:
            temperatura.text = "ERROR"
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch(tabBar.selectedItem!){
        case tabBar.items![0]:
            temperatura.text = "19ºC"
        case tabBar.items![1]:
            temperatura.text = "20ºC"
        case tabBar.items![2]:
            temperatura.text = "18ºC"
        case tabBar.items![3]:
            temperatura.text = "18ºC"
        case tabBar.items![4]:
            temperatura.text = "19ºC"
        case tabBar.items![5]:
            temperatura.text = "20ºC"
        default:
            temperatura.text = "ERROR"
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
