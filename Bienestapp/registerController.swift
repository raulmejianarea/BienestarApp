//

import UIKit
import Alamofire

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
        if isValidEmail(emailID: registerEmail) == false {
                 createAlert(title: "Error en el email", message: "El formato del email no es valido")
            }
        
        guard let registerPassword = password.text, password.text?.count != 0 else {
            createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
            return
        }
        
        registerUser(name: registerName, email: registerEmail, password: registerPassword, sender: sender) {
            print("se ha registrado correctamente")
        }
     
      
        
    }
    func createAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
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
    
}




    

