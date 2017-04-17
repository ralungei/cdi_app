//
//  SecurityViewController.swift
//  CDI
//
//  Created by ETSISI on 16/4/17.
//  Copyright © 2017 ETSISI. All rights reserved.
//

import UIKit
import UserNotifications

class SecurityViewController: UIViewController {

    @IBAction func incendio(_ sender: Any) {
        let content = UNMutableNotificationContent()
            content.title = "Emergencia!"
            content.body = "La alarma de incendios se ha activado!"
            content.badge = 1
            
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func temperatura(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Peligro!"
        content.body = "La temperatura de las instalaciones son peligrosas!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    @IBAction func humedad(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Peligro!"
        content.body = "La humedad de las instalaciones son peligrosas!"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the menu
        if (self.revealViewController() != nil){
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // Setup notifications
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
