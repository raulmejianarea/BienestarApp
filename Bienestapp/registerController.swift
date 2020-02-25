//

import UIKit
import Alamofire
import OHHTTPStubs

var apps: [App] = []

class registerController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        
    }
    
    @IBAction func register(_ sender: Any) {
    
       guard let registerName = name.text, name.text?.count != 0 else {
                createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
        return
        }
        
        guard let registerEmail = email.text, email.text?.count != 0 else {
                createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
                return
        }
        if HelperController.isValidEmail(emailID: registerEmail) == false {
                createAlert(title: "Error en el email", message: "El formato del email no es valido")
            }
        
        guard let registerPassword = password.text, password.text?.count != 0 else {
            
                createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
            return
        }
        
        registerUser(name: registerName, email: registerEmail, password: registerPassword, sender: sender, completion: {result in
            
            if result == true{
                self.performSegue(withIdentifier: "login", sender: sender)
            }else{
                
            }
                
            })
      
     
      
        
    }

    func createAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
 
    func registerUser(name: String, email: String, password: String, sender: Any, completion: @escaping (Bool) -> ()) {
    let url = URL(string: "http://localhost:8888/api-bienestar/public/api/register")!
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
    
    func store_apps_data(text: String){
        
        let store_apps_list_url = URL(string:  "http://localhost/apibienestar/public/api/store_apps_data")!
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
        let json = ["csv": text]
        
        Alamofire.request(store_apps_list_url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            switch(response.response?.statusCode){
            case 200:
               print("almacenando datos")
            default:
                print("default")
            }
        }
    }
    
    
    
}

    

