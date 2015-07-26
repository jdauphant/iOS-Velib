//
//  Update.swift
//  iOS-Velib
//
//  Created by Julien DAUPHANT on 26/07/15.
//  Copyright (c) 2015 Julien Dauphant. All rights reserved.
//

import Foundation

struct Update {
    let number: Int
    let key: String
    let newValue: Int
    let oldValue: Int
    
    init?(fromNSDictionary dict: NSDictionary) {
        if let number = dict["number"] as? Int,
            key = dict["key"] as? String,
            newValue = dict["newValue"] as? Int,
            oldValue = dict["oldValue"] as? Int {
                self.number = number
                self.key = key
                self.newValue = newValue
                self.oldValue = oldValue
        } else {
            return nil
        }
    }
    var description: String {
        return "Update(\(number),\(key),\(newValue),\(oldValue))"
    }
}