//
//  AppsController.swift
//  Bienestapp
//
//  Created by user161817 on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class AppsController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var Apps = [App]()
    var Statistics_Apps = [Statistics]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
//        GetStatistics {
//              self.tableView.reloadData()
//
//
//        }
        GetApps {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.AppName.text = Apps[indexPath.row].name
        cell.UseTime.text = Statistics_Apps[indexPath.row].total_time
        
        let baseURL = URL(string: "http://localhost/apibienestar/storage/app/")!
        let placeholderImage = UIImage(named: "logo App.png")
        let remoteImageURL = baseURL.appendingPathComponent(Apps[indexPath.row].logo!)
        
        print(remoteImageURL)
        cell.AppLogo?.sd_setImage(with: remoteImageURL, placeholderImage: placeholderImage)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func GetApps (completed: @escaping () -> ()) {
        let url = URL(string: localhost + "/listarApps")
          
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
          
          Alamofire.request(url!, method: .get, headers: headers).responseJSON { (response) in
              print(response)
              print("1")
              do {
                self.Apps = try JSONDecoder().decode([App].self, from: response.data!)
                  DispatchQueue.main.async{
                    self.GetStatistics {
                         completed()
                       }
                    
                  }
                  
              }catch {
                  print(error)
                 
              }
          }.resume()
      }
    
    func GetStatistics(completed: @escaping () -> ()) {
        
        let url = URL(string: localhost + "/get_apps_statistics")
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        
        let headers = ["Authorization" : user_token]
    
        Alamofire.request(url!, method: .get, headers: headers).responseJSON {
            
            (response) in
            
            print(response)
         
            do {
                
                    self.Statistics_Apps = try JSONDecoder().decode([Statistics].self, from: response.data!)
                    DispatchQueue.main.async{
                        completed()
                    }
            }catch{
                
            }

        }.resume()
    }
    
   
}
