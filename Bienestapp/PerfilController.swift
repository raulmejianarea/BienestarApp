//
//  PerfilController.swift
//  Bienestapp
//
//  Created by user161817 on 24/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class PerfilController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        getUserData()
    }
    

    func getUserData() {
        let url = URL( string: "http://localhost/api-bienestar/public/api/get_user_data")!
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
        
        print(headers)
        
        Alamofire.request(url, headers: headers).responseJSON {
            
            response in
            
            if let json = response.result.value as? [String: Any] {
                
                print(json)
                
                self.Name.text = json["name"]! as? String
                self.email.text = json["password"]! as? String
                self.password.text = json["email"]! as? String
                
                
            }
        }
        
        
    }

}
