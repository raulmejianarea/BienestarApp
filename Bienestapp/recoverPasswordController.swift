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
        
        Network.recoverPassword(email: recoverEmail, confirm_email: confirmationRecoverEmail,sender: sender, completion: {result in
            
            if result == true{
                self.createAlert(title: "succesful", message: "La contraseña ha sido enviada a tu correo.")
            }else if result == false{
                self.createAlert(title: "error", message: "No se ha podido restablecer tu contraseña.")
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
    
    
   
}

