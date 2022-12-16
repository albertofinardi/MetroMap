//
//  MainViewModel.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation

class MainViewModel : ObservableObject {
    
    @Published var db : [City]
    @Published var city : City
    @Published var line : Line
    @Published var stop : Stop
    
    let helper = LiveActivityHelper.shared
    let locationManager = LocationManager()
    
    init() {
        let db = Decoder("db").db
        print(db)
        self.db = db
        self.city = db.first ?? City(name: "Test", lines: [])
        self.line = db.first?.lines.first ?? Line(name: "Test", color: "Test", stops: [])
        self.stop =  db.first?.lines.first?.stops.first ?? Stop(name: "Test", latitude: 0, longitude: 0)
    }
    
    func startLiveActivity() {
        helper.end()
        Settings.shared.stop = self.stop
        Settings.shared.line = self.line
        Settings.shared.city = self.city
        locationManager.start()
        helper.start()
    }
    
    func stopLiveActivity(){
        helper.end()
        locationManager.stop()
    }
}
