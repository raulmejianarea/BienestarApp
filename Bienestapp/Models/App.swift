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
    var name : String?
    var total_time : String?
    var day_average : String?
    var week_average : String?
    var month_average : String?
}

class Coordinates : Codable {
    
    var name: String
    var latitude: Double
    var longitude: Double

}
