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
import MapKit
import SDWebImage

class MapsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapkit: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Network.GetApps {
            
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        Site()
        Network.coordinates {
            for app in Network.apps_coordinates {
                self.Markers(latitude: app.latitude, Longitud: app.longitude, title: app.name, subtitle: "ultimo lugar de uso")
            }
        }
        
       
    }
    //funcion que centra el mapa en un sitio especifico
    func Site (){
        let madrid = CLLocationCoordinate2D(latitude: 40.4893538, longitude: -3.703790)
        let region = MKCoordinateRegion(center: madrid, latitudinalMeters: 80000, longitudinalMeters: 80000)
        mapkit.setRegion(region, animated: true)
    }
    //funcion que genera marcas en el mapa
    func Markers (latitude: CLLocationDegrees, Longitud: CLLocationDegrees, title: String, subtitle: String) {
        let annontation = MKPointAnnotation()
        annontation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: Longitud)
        annontation.title = title
        annontation.subtitle = subtitle
        mapkit.addAnnotation(annontation)
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
