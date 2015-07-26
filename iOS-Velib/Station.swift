//
//  Station.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 26/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import Foundation

struct Station {
    let number: Int
    let name: String
    let position: Position
    let bikeStands: Int
    let availableBikeStands: Int
    let availableBikes: Int
    
    init?(fromNSDictionary dict: NSDictionary) {
        if let number = dict["number"] as? Int,
            name = dict["name"] as? String,
            positionDict = dict["position"] as? NSDictionary,
            position = Position(fromNSDictionary: positionDict),
            bikeStands = dict["bike_stands"] as? Int,
            availableBikeStands = dict["available_bike_stands"] as? Int,
            availableBikes = dict["available_bikes"] as? Int
            {
                self.number = number
                self.name = name
                self.position = position
                self.bikeStands = bikeStands
                self.availableBikeStands = availableBikeStands
                self.availableBikes = availableBikes
        } else {
            return nil
        }
    }
    
    var description: String {
        return "Station(\(number),\(name),\(position),\(bikeStands),\(availableBikeStands),\(availableBikes))"
    }
}