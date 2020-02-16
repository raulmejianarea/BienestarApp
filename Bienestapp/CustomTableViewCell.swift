//
//  CustomTableViewCell.swift
//  Bienestapp
//
//  Created by alumnos on 11/02/2020.
//  Copyright © 2020 alumnos. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    // Elementos de la App Screen
    @IBOutlet weak var AppLogo: UIImageView!
    @IBOutlet weak var AppName: UILabel!
    @IBOutlet weak var UseTime: UILabel!
    
    //Elementos del Map Screen
    @IBOutlet weak var LogoApp: UIImageView!
    @IBOutlet weak var NameApp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
