//
//  MetroStructs.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation
import UIKit

struct City : Codable, Hashable {
    var name : String
    var lines : [Line]
}

struct Line : Codable, Hashable {
    var name : String
    var color : String
    var stops : [Stop]
}

struct Stop : Codable, Hashable {
    var name : String
    var location : Coordinate
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.location = Coordinate(latitude: latitude, longitude: longitude)
    }
    
}

struct Coordinate: Codable, Hashable {
    let latitude, longitude: Double
}

class Decoder {
    @Published var db : [City]
    init(_ filename : String) {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let data = try decoder.decode([City].self, from: jsonData)
                self.db = data
                
            } catch {
                print("Error: \(error)")
                self.db = []
            }
        } else {
            self.db = []
        }
    }
}
