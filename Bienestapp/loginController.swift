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
//        guard let loginemail = email.text, email.text?.count != 0 else {
//                      createAlert(title: "Fallo", message: "Pon tu Usuario para continuar")
//                      return
//                  }
//                  if isValidEmail(emailID: loginemail) == false {
//                      createAlert(title: "Fallo", message: "Pon un email correcto")
//                  }
//                  
//              guard let loginpassword = password.text, password.text?.count != 0 else {
//                      createAlert(title: "Fallo", message: "Pon tu contraseña para continuar")
//                      return
//                  }
        
        
    }
    
    
    
     func createAlert(title: String, message: String)  {
           let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
               alert.dismiss(animated: true, completion: nil)
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
      //metodo que verificia si el correo cumple los estandares validos ejemplo xcode@gmail.com
      
      func isValidEmail(emailID: String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
          let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: emailID)
      }
    
    func loginUser(email: String, password: String, sender: Any, completion: @escaping (Bool, Bool) -> ()) {
        let url = URL(string: "http://localhost:8888/AutoPro-API-features-migrations/public/api/loginApp")
        let json = ["email": email,
                    "password": password,
                    "api_token": "24"]
        
        Alamofire.request(url!, method: .post, parameters: json, headers: nil).responseJSON { (response) in
            print(response)

//            do {
//
//                let rs: PostUserResponse = try JSONDecoder().decode(PostUserResponse.self, from: response.data!)
//                print(rs.error_msg!)
//
//                if rs.error_code == 200 {
//
//                    if rs.error_msg == "Profesor" {
//                       completion(true,false)
//                    }else if rs.error_msg == "Alumno"{
//                        completion(true, true)
//
//                    }
//
//                }else if rs.error_code == 404 {
//                    completion(false, false)
//                    self.createAlert(title: "error", message: "email o contraseña incorrectos")
//                }
//            }catch {
//                print(error)
//            }
//
//        }
    }
    
  
}

}
