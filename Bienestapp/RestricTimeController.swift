//
//  RestricTimeController.swift
//  Bienestapp
//
//  Created by user161817 on 15/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire
import MSCircularSlider

class RestricTimeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var CollectionView: UICollectionView!

    @IBOutlet weak var time_maximum: UITextField!
    @IBOutlet weak var initialTime: UITextField!
    @IBOutlet weak var finishTime: UITextField!
    @IBOutlet weak var vista: UIView!
    
    let maximum_time = UIDatePicker()
    let initial_time = UIDatePicker()
    let finish_time = UIDatePicker()
    
    var ids : Int?


//    @IBAction func circleSlider(_ sender: MSCircularSlider) {
//        let date_formater = DateFormatter()
//        date_formater.dateFormat = "HH:mm"
//        SliderCircular._commaSeparatedLabels  = date_formater.string(from: maximum_time.date)
//
//
//        if SliderCircular.currentValue >= 1 {
//            print(String(Float(sender._currentValue)))
//        }
//    }
    
    
    func createAlert(title: String, message: String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (Action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Do any additional setup after loading the view.
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        CollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        CollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        CollectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
  
        Network.GetApps {
            self.CollectionView.reloadData()
        }
//        print(SliderCircular._currentValue)
        
        maximum_time.datePickerMode = .time
        maximum_time.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        time_maximum.inputView = maximum_time
        maximum_time.addTarget(self, action: #selector(RestricTimeController.maximum_time_date_changed(datePicker:)), for: .valueChanged)

        initial_time.datePickerMode = .time
        initial_time.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        initialTime.inputView = initial_time
        initial_time.addTarget(self, action: #selector(RestricTimeController.initial_time_date_changed(datePicker:)), for: .valueChanged)

        finish_time.datePickerMode = .time
        finish_time.locale = NSLocale.init(localeIdentifier: "es_ES") as Locale
        finishTime.inputView = finish_time
        finish_time.addTarget(self, action: #selector(RestricTimeController.finish_time_date_changed(datePicker:)), for: .valueChanged)

        let hide = UITapGestureRecognizer(target: self, action: #selector(RestricTimeController.view_tapped(gestureRecognizer:)))
        vista.addGestureRecognizer(hide)

    }
    
    @objc func view_tapped(gestureRecognizer: UITapGestureRecognizer){

        view.endEditing(true)
    }

    @objc func maximum_time_date_changed(datePicker: UIDatePicker){

        let date_formater = DateFormatter()
        date_formater.dateFormat = "HH:mm"
        time_maximum.text = date_formater.string(from: maximum_time.date)


    }
    @objc func initial_time_date_changed(datePicker: UIDatePicker){

        let date_formater = DateFormatter()
        date_formater.dateFormat = "HH:mm"
        initialTime.text = date_formater.string(from: initial_time.date)


    }
    @objc func finish_time_date_changed(datePicker: UIDatePicker){

        let date_formater = DateFormatter()
        date_formater.dateFormat = "HH:mm"
        finishTime.text = date_formater.string(from: finish_time.date)


    }
  
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Network.Apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell

        cell.NameApp.text = Network.Apps[indexPath.row].name
        
        //Mostrar imagenes mediante la url con sdWebImage
        let baseURL = URL(string: "http://localhost/apibienestar/storage/app/")!
        let placeholderImage = UIImage(named: "logo App.png")
        let remoteImageURL = baseURL.appendingPathComponent(Network.Apps[indexPath.row].logo!)
        print(remoteImageURL)
        cell.Imagecell.sd_setImage(with: remoteImageURL, placeholderImage: placeholderImage)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let id : Int = Network.Apps[indexPath.row].id!
       
        ids = Seleccion(id: id)
        
    }
    
    @IBAction func buttonSave(_ sender: Any) {
     
        
        if ids != nil {
            if time_maximum.text!.isEmpty || initialTime.text!.isEmpty || finishTime.text!.isEmpty {
                createAlert(title: "Aviso", message: "Todos los campos deben estar rellenos")
            }else if initialTime.text! > finishTime.text! {
                createAlert(title: "Aviso", message: "El campo hora inicial no puede ser mayor que el campo hora final")
            }else{
                
                let stringId : String = "\(ids!)"
                
               restrict(id: stringId, completion: {result in
                    
                    if result == true{
                        self.createAlert(title: "Aviso", message: "Se ha realizado correctamente la restricion ")
                        self.ids = nil
                        self.time_maximum.text = ""
                        self.initialTime.text = ""
                        self.finishTime.text = ""
                    }
                    
                })
            }
        }else {
            createAlert(title: "Aviso", message: "Seleccion una app para poder realizar la restriccion")
        }
        
        
    }
  
    func Seleccion (id: Int) -> Int {
        return id
    }
    
 func restrict (id : String, completion: @escaping (Bool) -> ())  {
        let url = URL(string: localhost + "/create_restriction/" + id)
    
         let json = ["maximum_usage_time": time_maximum.text!, "usage_from_hour": initialTime.text!, "usage_to_hour": finishTime.text!]
        let user_token: String = UserDefaults.standard.value(forKey: "token") as! String
        let headers = ["Authorization" : user_token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            switch(response.response?.statusCode){
            case 200:
                
                completion(true)
            case 401:
                completion(false)
            default:
               print("error")
            }
            
        }
    }
   
}
