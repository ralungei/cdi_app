//
//  TemperatureViewController.swift
//  CDI
//
//  Created by ETSISI on 16/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UITabBarDelegate {
    
    var temperaturas = ["19ºC", "20ºC", "18ºC", "19ºC", "20ºC", "20ºC"]
    var humedades = ["52%", "54%", "56%", "52%", "51%", "56%"]
    
    var temperaturasDeseadas = ["20", "20", "19", "18", "20", "20"]
    var humedadesDeseadas = ["50", "52", "52", "54", "54", "54"]
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var temperatura: UILabel!
    @IBOutlet weak var humedad: UILabel!
    
    @IBOutlet weak var temperaturaButton: UIButton!
    @IBOutlet weak var humedadButton: UIButton!
    
    @IBAction func temperaturaAction(_ sender: Any) {
        
        let temperaturaChange = UIAlertController.init(title: nil, message: "Introduzca la temperatura deseada:", preferredStyle: .alert)
        
        temperaturaChange.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Temperatura"
            textField.text = self.temperaturasDeseadas[(self.tabBar.selectedItem?.tag)!]

        })
        
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {(action)  in
            let textField = temperaturaChange.textFields![0]
            self.temperaturasDeseadas[(self.tabBar.selectedItem?.tag)!] = textField.text!
            self.temperaturaButton.titleLabel?.text = "DESEADA: \(textField.text!)ºC"

        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
        
        temperaturaChange.addAction(okAction)
        temperaturaChange.addAction(cancelAction)
        
        temperaturaChange.popoverPresentationController?.sourceView = self.view
        temperaturaChange.popoverPresentationController?.sourceRect = self.temperaturaButton.accessibilityFrame
        self.present(temperaturaChange, animated: true, completion: nil)
    }

    @IBAction func humedadAction(_ sender: Any) {
        let humedadChange = UIAlertController.init(title: nil, message: "Introduzca la humedad deseada:", preferredStyle: .alert)
        
        humedadChange.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Humedad"
            textField.text = self.humedadesDeseadas[(self.tabBar.selectedItem?.tag)!]
            
        })
        
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {(action)  in
            let textField = humedadChange.textFields![0]
            self.humedadesDeseadas[(self.tabBar.selectedItem?.tag)!] = textField.text!
            self.humedadButton.titleLabel?.text = "DESEADA: \(textField.text!)%"
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            print("cancel")
        })
        
        humedadChange.addAction(okAction)
        humedadChange.addAction(cancelAction)
        
        humedadChange.popoverPresentationController?.sourceView = self.view
        humedadChange.popoverPresentationController?.sourceRect = self.humedadButton.accessibilityFrame
        self.present(humedadChange, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.selectedItem = tabBar.items?[0]

    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        temperatura.text = temperaturas[item.tag]
        humedad.text = humedades[item.tag]
        temperaturaButton.titleLabel?.text = "DESEADA: \(temperaturasDeseadas[item.tag])ºC"
        humedadButton.titleLabel?.text = "DESEADA: \(humedadesDeseadas[item.tag])%"
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
