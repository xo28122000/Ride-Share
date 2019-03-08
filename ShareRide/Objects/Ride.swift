//
//  Ride.swift
//  ShareRides
//
//  Created by Pablo Escriva on 27/02/2019.
//  Copyright © 2019 Pablo Escriva. All rights reserved.
//
import Foundation
import UIKit

class Ride {
    
    var id : String
    var driver : String
    var time : String
    var dropoff_location : String
    var cost : String
    var driverid : String
    var max_riders : Int
    init(id:String,driver:String,time:String,dropoff_location:String,cost:String,max_riders:Int,driverid:String) {
            self.id = id
            self.driver = driver
            self.time = time
            self.dropoff_location = dropoff_location
            self.cost = cost
            self.max_riders = max_riders
            self.driverid = driverid
    }
}
