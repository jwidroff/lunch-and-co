//
//  PizzaModel.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/18/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import Foundation
import Firebase


class PizzaModel {
    
    var ref: DatabaseReference?
    var users = [String]()
    var confirmedIDCounter = 1
    var unconfirmedIDCounter = 1

    var confirmedOrder = [Order]()
    var order = Order()
    
    var tempUnconfirmedOrder = [Order]()
    var unconfirmedOrder: [Order] {
        
        get {
            
            return tempUnconfirmedOrder
        }
        set {
//            var counter = 1
            var orders = [Order]()
            
            ref?.child("unconfirmedOrders").observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let snapshot = snapshot.value as? [String : String] {
                    
                    for snap in snapshot {
                        self.order = Order(name: snap.value, slices: 1)
                        orders.append(self.order)
                        self.unconfirmedIDCounter += 1
                    }
                    self.tempUnconfirmedOrder = orders
                    print("tempUnconfirmedOrder1\(self.tempUnconfirmedOrder)")
                    
                    if let lastNewValue = newValue.last {
                        self.ref?.child("unconfirmedOrders").child("unconfirmedID\(self.tempUnconfirmedOrder.count)").setValue(lastNewValue.name)
                        self.tempUnconfirmedOrder.append(newValue.last!)
                    }
                    
                    if newValue.count == 8 {
                        
                        print("8!")
                        self.confirmedOrder = self.tempUnconfirmedOrder
                        self.tempUnconfirmedOrder = [Order]()
                        self.ref?.child("unconfirmedOrders").removeValue()
                        
                        for order in self.confirmedOrder {
                            self.ref?.child("confirmed").child("confirmedID\(self.confirmedIDCounter)").setValue(order.name)
                            self.confirmedIDCounter += 1
                        }
                    }
                } else {
                    if let lastNewValue = newValue.last {
                        self.ref?.child("unconfirmedOrders").child("unconfirmedID\(self.tempUnconfirmedOrder.count)").setValue(lastNewValue.name)
                        self.tempUnconfirmedOrder.append(newValue.last!)
                    }
                }
            })
        }
    }

    var slicesInThisPie: Int {
        
        get {
            var number2Return = Int()
            if confirmedOrder.count + unconfirmedOrder.count > 8 {
                number2Return = (confirmedOrder.count + unconfirmedOrder.count) % 8
            } else {
                number2Return = (confirmedOrder.count + unconfirmedOrder.count)
            }
            return number2Return
        }
    }
    
    init() {
    }
    
    init(databaseReference: DatabaseReference) {
        
        ref = databaseReference
        
        users = ["JSW", "ME", "AK", "EL", "AS", "YD"]
    }
}
