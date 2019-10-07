//
//  InfoView.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/6/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class InfoView: UIView {

    //Add navigationController to be able to go back and forth between different orders on different days
    
//    let tableView = UITableView()
//    var confirmedOrders = [Order]()
//    var unconfirmedOrders = [Order]()
    var orders = [Order]()

    
    let tableView = UITableView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame: CGRect, confirmedOrders: [Order], unconfirmedOrders: [Order]) {
        super.init(frame: frame)

//        self.confirmedOrders = confirmedOrders
//        self.unconfirmedOrders = unconfirmedOrders
        
        orders.append(contentsOf: confirmedOrders)
        orders.append(contentsOf: unconfirmedOrders)
        
        print(confirmedOrders.map({$0.name}))
        print(unconfirmedOrders.map({$0.name}))

        tableView.frame = bounds
        self.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
//    func prepareCell() {
//        
//        
//        
//        
//        
//        
//        
//    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}



extension InfoView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orders.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        print("order name = \(orders[indexPath.row].name)")
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(orders[indexPath.row].name ?? "Failed") - \(orders[indexPath.row].slices!)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //MARK: Pick back up here - trying to get the unconfirmed and confirmed orders to have their own titles
        
        print(orders.map({$0.confirmed}))
        
        
        var title = ""
        
        

        if orders[section].confirmed == true {
            title = "Confirmed"
        } else {
            title = "Unconfirmed"
        }
        
        return title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    
    
    
}








