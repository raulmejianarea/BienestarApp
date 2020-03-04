//
//  App.swift
//  Bienestapp
//
//  Created by user161817 on 15/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Foundation

class App: Codable{
    
    var id : Int?
    var name : String?
    var logo : String?
    
    
    
//    init(json: [String: Any]) {
//
//        id = json["id"] as? Int ?? 0
//        name = json["name"] as? String ?? ""
//        logo = json["logo"] as? String ?? ""
//
//
//    }

}
class Statistics : Codable{
    var total_time : String?
}

class Coordinates : Codable {
    
    var name: String
    var latitude: Double
    var longitude: Double

}
