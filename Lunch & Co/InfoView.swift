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
    let toolbarHeight: CGFloat = 40
    
    var confirmedOrders = [Order]()
    var unconfirmedOrders = [Order]()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame: CGRect, confirmedOrders: [Order], unconfirmedOrders: [Order]) {
        super.init(frame: frame)
        
        
        self.confirmedOrders = confirmedOrders
        self.unconfirmedOrders = unconfirmedOrders
        setFormatting()
        setupView()

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    

    func setFormatting() {
        
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
        
    }
    
    func setupView() {
        
        let x = bounds.minX
        let y = bounds.minY + toolbarHeight
        let height: CGFloat = frame.height - toolbarHeight
        let width: CGFloat = frame.width
        let frameForTableView = CGRect(x: x, y: y, width: width, height: height)
        self.addSubview(tableView)
        tableView.frame = frameForTableView
        tableView.delegate = self
        tableView.dataSource = self
        addToolBar()
    }
    
    
    func addToolBar() {
        
        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
        toolBar.frame.size = CGSize(width: frame.width, height: 40.0)
        toolBar.clipsToBounds = true
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(InfoView.dismissView))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.addSubview(toolBar)
        
        
        
    }
    
    @objc func dismissView() {
        
        removeFromSuperview()
        
//        self.dismiss(animated: true, completion: nil)
        //        view.endEditing(true)
    }
    
    
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






