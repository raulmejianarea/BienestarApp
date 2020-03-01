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
    var Satistics_Apps = [Satistics]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        GetApps {
//             self.tableView.reloadData()
//        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.AppName.text = apps[indexPath.row].name
        cell.UseTime.text = Satistics_Apps[indexPath.row].total_time
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func GetApps (completed: @escaping () -> ()) {
        let url = URL(string: localhost + "/listarApps")
          
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
          
          Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
              print(response)
              
              do {
                self.Apps = try JSONDecoder().decode([App].self, from: response.data!)
                  DispatchQueue.main.async{
                    self.GetSatistics {
                        
                    }
                      completed()
                  }
                  
              }catch {
                  print(error)
                 
              }
          }.resume()
      }
    
    func GetSatistics(completion: @escaping () -> ()) {
        
        let url = URL(string: localhost + "/get_apps_statistics")
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
    
        Alamofire.request(url!, method: .get, headers: headers).responseJSON {
            
            response in
            do {
                if response.response?.statusCode == 200 {
                    self.Satistics_Apps = try JSONDecoder().decode([Satistics].self, from: response.data!)
                    DispatchQueue.main.async{
                        completion()
                    }
                }else if response.response?.statusCode == 401 {
                    completion()
                    print("error")
                }
 
            }catch{
                
            }

        }
    }
    
   
}
