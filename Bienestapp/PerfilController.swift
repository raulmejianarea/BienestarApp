//
//  PerfilController.swift
//  Bienestapp
//
//  Created by user161817 on 24/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class PerfilController: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    
    @IBOutlet weak var notifications: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self

//        getUserData()
    }
    @IBAction func Notifications(_ sender: UISwitch) {
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

    func getUserData() {
        let url = URL( string: "http://localhost:8888/api-bienestar/public/api/get_user_data")!
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
        
        print(headers)
        
        Alamofire.request(url, headers: headers).responseJSON {
            
            response in
            
            print(response)
            
            if let json = response.result.value as? [String: Any] {
                
                print(json)
                
                self.Name.text = json["name"]! as? String
                self.email.text = json["email"]! as? String
                self.password.text = json["password"]! as? String
                
                
            }
        }
        
        
    }

}
