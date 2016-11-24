//
//  DataStore.swift
//  Where Was I
//
//  Created by Ronald Morgan on 11/23/16.
//  Copyright © 2016 Ronald Morgan. All rights reserved.
//

import Foundation

struct Storagekeys {
    
    static let storedLat = "storedLat"
    static let storedLong = "storedLong"
}

class DataStore{
    func getDefaults() -> UserDefaults{
        return UserDefaults.standard
    }
    
    func StoreDataPoint (latitude: String, longitude: String){
        let def = getDefaults()
        
        def.setValue(latitude, forKey: Storagekeys.storedLat)
        def.setValue(longitude, forKey: Storagekeys.storedLong)
        
        def.synchronize()
    }
    
    func GetLastLocation () -> VisitedPoint?{
        let defaults = getDefaults()
        
        if let lat = defaults.string(forKey: Storagekeys.storedLat) {
            if let long = defaults.string(forKey: Storagekeys.storedLong) {
            return VisitedPoint(lat: lat, long: long)
                }
            }
        return nil


    }
}


