//
//  Settings.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation

class Settings {
    
    static let shared = Settings()
    
    var line : Line = Line(name: "", color: "", stops: [])
    var city : City = City(name: "", lines: [])
    var stop : Stop = Stop(name: "", latitude: 0, longitude: 0)
    
    var notNotified : Bool = true
}
