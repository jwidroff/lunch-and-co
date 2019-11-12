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
//    var counter = 0
    
    
    var confirmedOrder = [Order]()
    
    var tempUnconfirmedOrder = [Order]()
    var unconfirmedOrder: [Order] {
        
        get {
            
            
            return tempUnconfirmedOrder
            
            
//            var orders = [Order]()
//
//            ref?.child("unconfirmedOrders").observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let keyValueArray = snapshot.value as! [String : String]
//
//                let keyValueArraySorted = keyValueArray.sorted(by: ({$0.key < $1.key}))
//
//                for keyValue in keyValueArraySorted {
//
//                    let order = Order(name: keyValue.value, slices: 1)
//
//                    orders.append(order)
//
//                }
//
//            }, withCancel: { (error) in
//                print(error.localizedDescription)
//                print("L")
//            })
//
//
//            print(orders.map({$0.name}))
//            return orders
        }
        set {
            
            var counter = 0
            
            for order in newValue {
                ref?.child("unconfirmedOrders").child("unconfirmedID\(counter)").setValue(order.name)
                counter += 1
                
            }
            tempUnconfirmedOrder = newValue
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



