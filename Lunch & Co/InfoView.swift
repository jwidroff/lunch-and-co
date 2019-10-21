//
//  InfoView.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/6/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

//protocol CellDelegate {

//    func updateSlices() //update slicesInThisPie and totalSlices
//    func updateOrder(orderToRemove: Order, confirmed: Bool) //should add slices to confirmedOrder from unconfirmedOrder
//    func updatePieView() // Need to display the right amount of pies and slices shown
    
    
//}



class InfoView: UIView {

    //Add horizontal picker to be able to go back and forth between different orders on different days

    var ordersFormatted = [OrderFormatted]()
    let tableView = UITableView()
    let toolbarHeight: CGFloat = 40
    
//    var confirmedOrders = [Order]()
//    var unconfirmedOrders = [Order]()
//    var delegate: CellDelegate?
    
    var pizzaModel = PizzaModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init (frame: CGRect, pizzaModel: PizzaModel) {
        super.init(frame: frame)
        
        self.pizzaModel = pizzaModel
//        self.confirmedOrders = pizzaModel.confirmedOrder
//        self.unconfirmedOrders = pizzaModel.unconfirmedOrder
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
        
        ordersFormatted = [OrderFormatted]()
        
        var names = [String]()
        var slices = [String]()
        
        for order in pizzaModel.confirmedOrder {
            
            names.append(order.name!)
            slices.append("\(order.slices!)")
        }
        
        let confirmedOrdersFormatted = OrderFormatted(confirmed: "Confirmed", name: names, amountOfSlices: slices)
        
        names = [String]()
        slices = [String]()
        
        for order in pizzaModel.unconfirmedOrder {
            
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
        //TODO: Check to see if any
    }
    
    
}


extension InfoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "\(ordersFormatted[indexPath.section].name[indexPath.row]) - \(ordersFormatted[indexPath.section].amountOfSlices[indexPath.row])"
        
//        print(indexPath.row)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
//        var orderToBeRemoved = Order()
        
        if indexPath.section == 0 { // Unconfirmed Orders
            pizzaModel.unconfirmedOrder.remove(at: indexPath.row)
            setFormatting()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            
            print(pizzaModel.unconfirmedOrder.count)
            
            if pizzaModel.unconfirmedOrder.count != 0 {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                let indexPathXX = IndexPath(row: 0, section: 0)
                tableView.deleteRows(at: [indexPathXX], with: .automatic)
                let indexPathX = IndexPath(row: 7, section: 1)
                tableView.insertRows(at: [indexPathX], with: .automatic)
                
                pizzaModel.confirmedOrder.remove(at: indexPath.row)
                pizzaModel.confirmedOrder.append(pizzaModel.unconfirmedOrder[0])
                pizzaModel.unconfirmedOrder.remove(at: 0)
                setFormatting()
                tableView.endUpdates()
            } else {

                tableView.beginUpdates()
                for counter in 0..<pizzaModel.confirmedOrder.count {
                    let rowIndexPathAt = IndexPath(row: counter, section: 1)
                    let rowIndexPathTo = IndexPath(row: counter, section: 0)
                    tableView.moveRow(at: rowIndexPathAt, to: rowIndexPathTo)
                }
                pizzaModel.unconfirmedOrder = pizzaModel.confirmedOrder
                pizzaModel.confirmedOrder.removeAll()
                setFormatting()
                tableView.endUpdates()
                
                tableView.beginUpdates()
                let indexPathX = IndexPath(row: indexPath.row, section: 0)
                tableView.deleteRows(at: [indexPathX], with: .automatic)
                pizzaModel.unconfirmedOrder.remove(at: indexPathX.row)
                setFormatting()
                tableView.endUpdates()
            }
        }
    }
}


struct OrderFormatted {
    
    var confirmed:String
    var name:[String]
    var amountOfSlices:[String]
}






