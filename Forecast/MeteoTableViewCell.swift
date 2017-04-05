//
//  MeteoTableViewCell.swift
//  Forecast
//
//  Created by Maxime BINET on 4/5/17.
//  Copyright © 2017 Maxime BINET. All rights reserved.
//

import UIKit

class MeteoTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hourLabel: UILabel!
    
    var meteo : (Meteo)? {
        didSet {
            if let m = meteo {
                hourLabel?.text = String(describing: m.hour)
                textView?.text = m.text
            }
        }
    }
}
