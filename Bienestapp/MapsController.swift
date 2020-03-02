//
//  MapsController.swift
//  Bienestapp
//
//  Created by user161817 on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
import GooglePlaces
import SDWebImage

class MapsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.GetApps {
            
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        // Creates a marker in the center of the map.
          let marker = GMSMarker()
          marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
          marker.title = "Sydney"
          marker.snippet = "Australia"
          marker.map = mapView
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Network.Apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.NameApp?.text = Network.Apps[indexPath.row].name
        
        //Mostrar imagenes mediante la url con sdWebImage
        let baseURL = URL(string: "http://localhost/apibienestar/storage/app/")!
        let placeholderImage = UIImage(named: "logo App.png")
        let remoteImageURL = baseURL.appendingPathComponent(Network.Apps[indexPath.row].logo!)
        print(remoteImageURL)
        cell.LogoApp?.sd_setImage(with: remoteImageURL, placeholderImage: placeholderImage)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
   
}
