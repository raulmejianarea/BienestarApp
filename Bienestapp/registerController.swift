//

import UIKit
import Alamofire
import OHHTTPStubs


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
        
        Network.registerUser(name: registerName, email: registerEmail, password: registerPassword, sender: sender, completion: {result in
            
            if result == true{
                self.performSegue(withIdentifier: "login", sender: sender)
            }else{
                self.createAlert(title: "error", message: "no se ha podido realizar el register.")
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

    

