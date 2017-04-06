//
//  MeteoTableViewCell.swift
//  Forecast
//
//  Created by Maxime BINET on 4/5/17.
//  Copyright © 2017 Maxime BINET. All rights reserved.
//

import UIKit

class MeteoTableViewCell: UITableViewCell {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var meteo : (Meteo)? {
        didSet {
            if let m = meteo {
                hourLabel?.text = m.hour
                tempLabel?.text = m.text
                icon.image = UIImage(named: String("\(m.icon).png"))
            }
        }
    }
}
