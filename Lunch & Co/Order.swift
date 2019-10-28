//
//  Order.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/4/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import Foundation


class Order {
    
    var name: String?
    var slices: Int?
    
    init(name: String, slices: Int) {
        
        self.name = name
        self.slices = slices
    }
    init(){
        
    }
}

class ConfirmedOrder {
    
    var name: String?
    var slices: Int?
    
    init(name: String, slices: Int) {
        
        self.name = name
        self.slices = slices
    }
}
