//
//  AppsController.swift
//  Bienestapp
//
//  Created by user161817 on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire

class AppsController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var Apps = [App]()
    
    var students = ["Ben", "Ivy", "Jordell"]
    var fotos = [#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.AppName.text = students[indexPath.row]
        cell.AppLogo.image = fotos[indexPath.row]
        cell.UseTime.text = students[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func GetApps (completed: @escaping () -> ()) {
          let url = URL(string: "http://localhost:8888/AutoPro-API-features-migrations/public/api/lesson")
          
          let json = ["api_token": "24"]
          
          Alamofire.request(url!, method: .get, parameters: json, headers: nil).responseJSON { (response) in
              print(response)
              
              do {
                self.Apps = try JSONDecoder().decode([App].self, from: response.data!)
                  DispatchQueue.main.async{
                      completed()
                  }
                  
              }catch {
                  print(error)
                 
              }
          }.resume()
      }
    
   
}
