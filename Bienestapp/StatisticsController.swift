//
//  StatisticsController.swift
//  Bienestapp
//
//  Created by user161817 on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import MSCircularSlider

class StatisticsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hardcode_time : [String] = ["01:30:20", "06:15:10", "03:40:22", "05:25:09", "04:39:43", "02:23:50"]
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Network.GetStatistics {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Network.Statistics_Apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.name?.text = Network.Statistics_Apps[indexPath.row].name
        cell.day_time?.text = Network.Statistics_Apps[indexPath.row].day_average
        cell.time_week?.text = hardcode_time[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
   
}

