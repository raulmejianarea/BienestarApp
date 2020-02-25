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
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func GetApps (completed: @escaping () -> ()) {
        let url = URL(string: "http://localhost:8888/api-bienestar/public/api/listarApps")
          
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
          
          Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
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
    
//    func get_apps_data(){
//        let url = URL(string: local_host + "/api/app")!
//        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
//        let headers = ["Authorization" : user_token]
//        Alamofire.request(url, encoding: JSONEncoding.default, headers: headers).responseJSON {
//            response in
//            switch(response.response?.statusCode){
//            case 200:
//                print("OK")
//                if let json = response.result.value as? [[String: Any]] {
//                    for app in json {
//                        apps.append(App(json: app))
//                    }
//                    self.performSegue(withIdentifier: "login_to_menu", sender: nil)
//                }
//            case 400:
//                print("ERROR")
//            default:
//                print("DEFAULT")
//            }
//        }
//    }
    
   
}
