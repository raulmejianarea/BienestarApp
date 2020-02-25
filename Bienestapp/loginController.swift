//
//  ViewController.swift
//  Bienestapp
//
//  Created by alumnos on 16/01/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class loginController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logginButton(_ sender: UIButton) {
        
         self.performSegue(withIdentifier: "menu", sender: sender)
        
//        guard let loginemail = email.text, email.text?.count != 0 else {
//                      createAlert(title: "Fallo", message: "Pon tu Usuario para continuar")
//                      return
//                  }
//                  if HelperController.isValidEmail(emailID: loginemail) == false {
//                      createAlert(title: "Fallo", message: "Pon un email correcto")
//                  }
//
//              guard let loginpassword = password.text, password.text?.count != 0 else {
//                      createAlert(title: "Fallo", message: "Pon tu contraseña para continuar")
//                      return
//                  }
//
//                loginUser(email: loginemail, password: loginpassword, sender: sender, completion: {result in
//
//        if result == true{
//            self.performSegue(withIdentifier: "menu", sender: sender)
//        }else if result == false{
//            self.createAlert(title: "error", message: "email o contraseña incorrectos")
//        }
//
//    })
        
        
    }
    
    
    
      func createAlert(title: String, message: String)  {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
               alert.dismiss(animated: true, completion: nil)
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
     
      

    //metodo que realiza la peticion login a la Api
    func loginUser(email: String, password: String, sender: Any, completion: @escaping (Bool) -> ()) {
        let url = URL(string: "http://localhost:8888/api-bienestar/public/api/login")
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
                        
                        self.createAlert(title: "Error", message: "Email o contraseña incorrectos")
                        let message = json["message"] as! String
                        
                        print(message)
                    }
                }
                
            }catch {
                print(error)
            }
           
    }
}

}
