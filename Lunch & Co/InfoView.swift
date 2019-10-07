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
    //Need to add an back button to close the popup

    var ordersFormatted = [OrderFormatted]()
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
        
        var names = [String]()
        var slices = [String]()
        
        for order in confirmedOrders {
            
            names.append(order.name!)
            slices.append("\(order.slices!)")
        }
        
        let confirmedOrdersFormatted = OrderFormatted(confirmed: "Confirmed", name: names, amountOfSlices: slices)
        
        names = [String]()
        slices = [String]()
        
        for order in unconfirmedOrders {
            
            names.append(order.name!)
            slices.append("\(order.slices!)")
        }
        
        let unconfirmedOrdersFormatted = OrderFormatted(confirmed: "Unconfirmed", name: names, amountOfSlices: slices)
        
        ordersFormatted.append(unconfirmedOrdersFormatted)
        ordersFormatted.append(confirmedOrdersFormatted)

        tableView.frame = bounds
        self.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.color = .black

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}


extension InfoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(ordersFormatted[indexPath.section].name[indexPath.row]) - \(ordersFormatted[indexPath.section].amountOfSlices[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ordersFormatted[section].name.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ordersFormatted.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return ordersFormatted[section].confirmed
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}


struct OrderFormatted {
    
    var confirmed:String
    var name:[String]
    var amountOfSlices:[String]
}






