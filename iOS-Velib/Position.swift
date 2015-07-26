//
//  Position.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 26/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import Foundation

struct Position {
    let lat: Int
    let lng: Int
    
    init?(fromNSDictionary dict: NSDictionary) {
        if let lat = dict["lat"] as? Int,
            lng = dict["lng"] as? Int {
                self.lat = lat
                self.lng = lng
        } else {
            return nil
        }
    }
    
    var description: String {
        return "(lat:\(lat),lng:\(lng))"
    }
}