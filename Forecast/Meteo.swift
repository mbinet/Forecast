//
//  Meteo.swift
//  Forecast
//
//  Created by Maxime BINET on 4/5/17.
//  Copyright © 2017 Maxime BINET. All rights reserved.
//

import Foundation

struct Meteo: CustomStringConvertible {
    let hour : String
    let text : String
    let icon : String
    
    init(h: String, t: String, i: String) {
        self.hour = "\(h)h"
        self.text = "\(t)°"
        self.icon = i
    }
    
    var description: String {
        return "(\(hour), \(text), \(icon))"
    }
}
