//
//  Meteo.swift
//  Forecast
//
//  Created by Maxime BINET on 4/5/17.
//  Copyright © 2017 Maxime BINET. All rights reserved.
//

import Foundation

struct Meteo: CustomStringConvertible {
    let hour : Date
    let text : String
    
    init(h: Date, t: String) {
        self.hour = h
        self.text = t
    }
    
    var description: String {
        return "(\(hour), \(text))"
    }
}
