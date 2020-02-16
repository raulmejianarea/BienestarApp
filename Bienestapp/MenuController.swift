//
//  MenuController.swift
//  Bienestapp
//
//  Created by alumnos on 06/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class MenuController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var Notification: UISwitch!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().delegate = self
        
      }
    @IBAction func NotificationSwitch(_ sender: UISwitch) {
       
        if (sender.isOn == true){
               handleNotification(title: "hola", message: "eres un crack")
        }
    
    }
    
    @objc private func handleNotification(title: String, message: String){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8.0 , repeats: false)
        let request = UNNotificationRequest(identifier: "notificationLocal", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().add(request) { (error) in
            
            if let error = error {
                print("error al llamar la peticion de notificacion \(error)")
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
}


