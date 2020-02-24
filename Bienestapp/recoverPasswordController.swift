import UIKit
import Alamofire
class recoverPasswordController: UIViewController {
    
 
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var emailConfirmation: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func recoverPassword(_ sender: Any) {
        
        guard let recoverEmail = emailInput.text, emailInput.text?.count != 0 else {
            createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
            return
        }
        if HelperController.isValidEmail(emailID: recoverEmail) == false {
            createAlert(title: "Error en el email", message: "El formato del email no es valido")
        }
        
        guard let confirmationRecoverEmail = emailConfirmation.text, emailConfirmation.text?.count != 0 else {
            createAlert(title: "Campos vacios", message: "Tienes que rellenar todos los campos")
            return
        }
        if HelperController.isValidEmail(emailID: confirmationRecoverEmail) == false {
            createAlert(title: "Error en el email", message: "El formato del email no es valido")
        }
 
    }
    func createAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func recoverPassword(email: String, confirm_email: String) {
        let url = URL(string:"http://localhost/api-bienestar/public/api/recover_password")
        let json = ["email": email, "confirm_email": confirm_email]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            
            do {
              
                
                if response.response?.statusCode == 200 {
                    
                    if let json = response.result.value as? [String: Any]{
                         let message = json["message"] as! String
                        self.createAlert(title: "Informacion", message: message + " Haz loggin ")
                        
                    }
                }else if response.response?.statusCode == 401 {
                    
                    if let json = response.result.value as? [String: Any] {
                        let message = json["message"] as! String
                         self.createAlert(title: "Error", message: message)
                        print(message)
                    }
                }
                
            }catch {
                print(error)
            }
            
        }
    }
}

