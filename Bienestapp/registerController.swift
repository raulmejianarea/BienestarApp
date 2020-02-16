//

import UIKit
import Alamofire

class registerController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    
    @IBOutlet weak var error_name: UILabel!
    @IBOutlet weak var error_email: UILabel!
    @IBOutlet weak var error_password: UILabel!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
    
       guard let registerName = name.text, name.text?.count != 0 else {
        error_name.text = "El campo nombre no puede estar vacio"
        return
        }
        
        guard let registerEmail = email.text, email.text?.count != 0 else {
                error_email.text = "El campo email no puede estar vacio "
                return
        }
        if isValidEmail(emailID: registerEmail) == false {
                error_email.text = "El formato del email no es correcto "
            }else{
                error_email.text = " "
        }
        
        guard let registerPassword = password.text, email.text?.count != 0 else {
            error_password.text = "El campo password no puede estar vacio "
        }
        
        registerUser(name: registerName, email: registerEmail, password: registerPassword, sender: sender) {
            print("se ha registrado correctamente")
        }
     
      
        
    }
    
    func isValidEmail(emailID: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
    
    func isValidPassword(_ password: String) -> Bool {
          let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
          let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
          return passPred.evaluate(with: password)
      }
    
}


func registerUser(name: String, email: String, password: String, sender: Any, completion: @escaping () -> ()) {
    let url = URL(string: "http://localhost/apibienestar/public/api/register")
    let json = ["name": name,
                "email": email,
                "password": password
                ]
    
    Alamofire.request(url!, method: .post, parameters: json, headers: nil).responseJSON { (response) in
        print(response)
        
                    do {

                               completion()
        
                    }catch {
                        print(error)
                    }
        
                }
    }

    

