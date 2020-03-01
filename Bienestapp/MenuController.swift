//
//  MenuController.swift
//  Bienestapp
//
//  Created by alumnos on 06/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class MenuController: UIViewController {
    
  
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
       
       
      }
    
    @IBAction func mapaLabel(_ sender: Any) {

        self.performSegue(withIdentifier: "mapa", sender: sender)
        
    }
    
    @IBAction func appsLabel(_ sender: Any) {
      
        self.performSegue(withIdentifier: "apps", sender: sender)
        
    }
    @IBAction func estadisticasLabel(_ sender: Any) {
        
        self.performSegue(withIdentifier: "estadisticas", sender: sender)
       
        
    }
    
    @IBAction func limitadorLabel(_ sender: Any) {
    
        self.performSegue(withIdentifier: "limitador", sender: sender)
        
    }
    
    @IBAction func perfilLabel(_ sender: Any) {
        
        self.performSegue(withIdentifier: "perfil", sender: sender)
        
    }
    
    
   
}


