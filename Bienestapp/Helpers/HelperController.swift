//
//  HelperController.swift
//  Bienestapp
//
//  Created by user161817 on 18/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class HelperController: UIViewController {

   
    
      //metodo que verificia si el correo cumple los estandares validos ejemplo xcode@gmail.com
    static func isValidEmail(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let passPred = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passPred.evaluate(with: password)
    }

}
