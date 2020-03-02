//
//  Network.swift
//  Bienestapp
//
//  Created by raul on 01/03/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import Foundation
import Alamofire

let localhost : String = "http://localhost/apibienestar/public/api"

class Network{

    
    //metodo que realiza la peticion login a la Api
    class func loginUser(email: String, password: String, sender: Any, completion: @escaping (Bool) -> ()) {
        let url = URL(string: localhost + "/login")
        let json = ["email": email,
                    "password": password]
        
        Alamofire.request(url!, method: .post, parameters: json, headers: nil).responseJSON { (response) in
            print(response)
            
            do {
                if response.response?.statusCode == 200 {
                    completion(true)
                    if let json = response.result.value as? [String: Any]{
                        
                        let token = json["token"] as! String
                        UserDefaults.standard.set(token, forKey: "token")
                        
                    }
                }else if response.response?.statusCode == 401 {
                    completion(false)
                    if let json = response.result.value as? [String: Any] {
                     
                        let message = json["message"] as! String
                        
                        print(message)
                    }
                }
                
            }catch {
                print(error)
            }
            
        }
    }
    
    //peticion register
    class func registerUser(name: String, email: String, password: String, sender: Any, completion: @escaping (Bool) -> ()) {
        let url = URL(string: localhost + "/register")!
        let json = ["name": name,
                    "email": email,
                    "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: json, headers: nil).responseJSON { (response) in
            
            print(response)
            
            
            do {
                if response.response?.statusCode == 200 {
                    
                    if let json = response.result.value as? [String: Any]{
                        
                        let token = json["token"] as! String
                        UserDefaults.standard.set(token, forKey: "token")
                        completion(true)
                        
                    }
                }else if response.response?.statusCode == 401 {
                    
                    if let json = response.result.value as? [String: Any] {
                        
                        let message = json["message"] as! String
                        completion(false)
                        print(message)
                    }
                }
                
            }catch {
                print(error)
            }
            
        }
    }
    
    //Peticion recover
    class func recoverPassword(email: String, confirm_email: String, sender: Any, completion: @escaping (Bool) -> ()) {
        let url = URL(string: localhost + "/recover_password")
        let json = ["email": email, "confirm_email": confirm_email]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            
            do {
                
                
                if response.response?.statusCode == 200 {
                    
                    completion(true)
                    
                    
                }else if response.response?.statusCode == 401 {
                    
                    completion(false)
                    
                }
                
            }catch {
                print(error)
            }
            
        }
    }
    //Variables de la peticion Get Apps
    static var Apps = [App]()
    
    //Peticion Get Apps
    class func GetApps (completed: @escaping () -> ()) {
        let url = URL(string: localhost + "/listarApps")
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
        
        Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
            print(response)
            print("1")
            do {
                Apps = try JSONDecoder().decode([App].self, from: response.data!)
                DispatchQueue.main.async{
                    completed()
                }
                
            }catch {
                print(error)
                
            }
            }.resume()
    }
    //
    static var Statistics_Apps = [Statistics]()
    //peticion Get Statistics
    class func GetStatistics(completed: @escaping () -> ()) {
        
        let url = URL(string: localhost + "/get_apps_statistics")
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
        
        Alamofire.request(url!, method: .get, headers: headers).responseJSON {
            
            (response) in
            
            print(response)
            
            do {
                
                Statistics_Apps = try JSONDecoder().decode([Statistics].self, from: response.data!)
                DispatchQueue.main.async{
                    completed()
                }
            }catch{
                
            }
            
            }.resume()
    }
}
