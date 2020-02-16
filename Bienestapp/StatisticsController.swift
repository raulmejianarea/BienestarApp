//
//  StatisticsController.swift
//  Bienestapp
//
//  Created by user161817 on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import MTCircularSlider

class StatisticsController: UIViewController {
    
    @IBOutlet weak var Selector: MTCircularSlider!
    @IBOutlet weak var Hora: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    }
    
  
    @IBAction func OnSlidechange(_ sender: MTCircularSlider) {
        setValueLabelText()
        print(setValueLabelText())
        
    }
    
    fileprivate func setValueLabelText() {
       Hora.text = String(Int(Selector.value))
    }
    
    
    
   
}

