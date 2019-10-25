//
//  PizzaModel.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/18/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import Foundation

class PizzaModel {
    
    //MARK: Just moved variables here from VC. Need to move from other classes as well
    
    var users = [String]()
    var slicesInThisPie = Int()
    
//    var slicesInThisPie: Int {
//        get {
//           return unconfirmedOrder.count + confirmedOrder.count
//        }
//
//    }
//    var totalSlices = Int()
    var orders = [Order]()
    var confirmedOrder = [Order]()
    var unconfirmedOrder = [Order]()
    
    
    init() {
        
        users = ["JSW", "ME", "AK", "EL", "AS", "YD"]
        slicesInThisPie = 0
//        totalSlices = 0
        
    }
    
    
}






