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

class MapsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var tableView: UITableView!
    
     var students = ["Ben", "Ivy", "Jordell" ,"Ben", "Ivy", "Jordell" ,"Ben", "Ivy", "Jordell" ,"Ben", "Ivy", "Jordell"]
    var fotos = [#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg") ,#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg") ,#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg") ,#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        
        cell.NameApp?.text = students[indexPath.row]
        cell.LogoApp?.image = fotos[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
   
}
