//
//  LocationManager.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    private let helper = LiveActivityHelper.shared
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.delegate = self
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    private func updateLiveActivity(_ stop : Stop?) {
        self.helper.update(stop)
    }
    
    private func endLiveActivityAndNotify(_ stop : Stop?) {
        self.helper.endAndNotify(stop)
    }
    
    private func coordToLoc(coord: Coordinate) -> CLLocation {
        let getLat: CLLocationDegrees = coord.latitude
        let getLon: CLLocationDegrees = coord.longitude
        let newLoc: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        return newLoc
    }
    
    private func closestStop(line: Line, actualLocation location: CLLocation) -> Stop? {
        if line.stops.count == 0 {
            return nil
        }
        
        var closestStop: Stop?
        var smallestDistance: CLLocationDistance?
        
        for stop in line.stops {
            let loc = coordToLoc(coord: stop.location)
            let distance = location.distance(from: loc)
            if smallestDistance == nil || distance < smallestDistance! {
                closestStop = stop
                smallestDistance = distance
            }
        }
        return closestStop
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let closestStop = closestStop(line: Settings.shared.line, actualLocation: location)
        if closestStop == Settings.shared.stop && Settings.shared.notNotified {
            Settings.shared.notNotified.toggle()
            DispatchQueue.main.async {
                self.stop()
                self.endLiveActivityAndNotify(closestStop)
            }
        }
        DispatchQueue.main.async {
            self.updateLiveActivity(closestStop)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        manager.requestAlwaysAuthorization()
    }
}
