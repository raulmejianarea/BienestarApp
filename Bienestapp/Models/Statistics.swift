//
//  Statistics.swift
//  Bienestapp
//
//  Created by user161817 on 01/03/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//
import Foundation

class Satistics: Codable{
    
    var total_time: String
    var day_average: String
    var week_average: String
    var month_average: String
    
    init(json: [String: Any]) {
        total_time = json["total_time"] as? String ?? ""
        day_average = json["day_average"] as? String ?? ""
        week_average = json["week_average"] as? String ?? ""
        month_average = json["month_average"] as? String ?? ""
        
    }
}
