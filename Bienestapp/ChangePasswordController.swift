//
//  ChangePasswordController.swift
//  Bienestapp
//
//  Created by user161817 on 24/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordController: UIViewController {

    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmationNewPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.createAlert(title: "Info", message: "Al cambiar la contraseña tendras que volver hacer login")
        
    }
    
    @IBAction func SaveChange(_ sender: Any) {
        
        guard let PasswordOld = oldPassword.text, oldPassword.text?.count != 0 else {
            createAlert(title: "Fallo", message: "El campo antigua contraseña no puede estar vacio")
            return
        }
        guard let PasswordNew = newPassword.text, newPassword.text?.count != 0 else {
            createAlert(title: "Fallo", message: "El campo nueva contraseña no puede estar vacio")
            return
        }
        guard let PasswordNewConfirmation = confirmationNewPassword.text, confirmationNewPassword.text?.count != 0 else {
            createAlert(title: "Fallo", message: "El campo confirmacion de la nueva contraseña no puede estar vacio")
            return
        }
        
        if (PasswordNew == PasswordNewConfirmation){
           
            change_password(old_password: PasswordOld, new_password: PasswordNew, sender: sender, completion: {result in
                
                if result == true{
                    self.performSegue(withIdentifier: "login", sender: sender)
                }else if result == false{
                     self.createAlert(title: "error", message: "La contraseña antigua no es la correcta")
                }
                
            })
        }else {
            createAlert(title: "Error", message: "La nueva contraseña y la confirmacion deben coincidir")
        }
        
    }
    
    func createAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
   
    //peticion a la Api
    func change_password(old_password: String, new_password: String, sender: Any, completion: @escaping (Bool) -> ()) {
        
        let url = URL(string: localhost + "/change_user_password")!
        
        let json = ["old_password": old_password , "new_password": new_password]
        
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
        
        Alamofire.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseJSON {
            
            response in
            
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
    

}
