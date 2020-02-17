//
//  RestricTimeController.swift
//  Bienestapp
//
//  Created by user161817 on 15/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

//import MSCircularSlider

class RestricTimeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var CollectionView: UICollectionView!
    
      var fotos = [#imageLiteral(resourceName: "mujer.jpg"),#imageLiteral(resourceName: "mujer.jpg"), #imageLiteral(resourceName: "mujer.jpg")]
    var students = ["Ben", "Ivy", "Jordell"]
    
//    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
//
//    }
//
//    func circularSlider(_ slider: MSCircularSlider, startedTrackingWith value: Double) {
//
//    }
//
//    func circularSlider(_ slider: MSCircularSlider, endedTrackingWith value: Double) {
//
//    }
//
//    func circularSlider(_ slider: MSCircularSlider, directionChangedTo value: MSCircularSliderDirection) {
//
//    }
//
//    func circularSlider(_ slider: MSCircularSlider, revolutionsChangedTo value: Int) {
//
//    }
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return fotos.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
                     cell.Imagecell.image = fotos[indexPath.row]
        cell.NameApp.text = students[indexPath.row]
                  
                  return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CollectionView.delegate = self
        CollectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
  
    }
    
 
  
    
    
    
   
}
