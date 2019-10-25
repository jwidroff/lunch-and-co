//
//  InfoView.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/6/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

protocol CellDelegate {

//    func updateSlices() //update slicesInThisPie and totalSlices
//    func updateOrder(orderToRemove: Order, confirmed: Bool) //should add slices to confirmedOrder from unconfirmedOrder
    func updatePizzaView() // Need to display the right amount of pies and slices shown
    
}

class InfoView: UIView {

    //Add horizontal picker to be able to go back and forth between different orders on different days

    var ordersFormatted = [OrderFormatted]()
    let tableView = UITableView()
    let toolbarHeight: CGFloat = 40
    

    var delegate: CellDelegate?
    
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
        toolBar.frame.size = CGSize(width: frame.width, height: 40.0)
        toolBar.clipsToBounds = true
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(InfoView.dismissView))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.addSubview(toolBar)
    }
    
    func removeOneSliceFromUnconfirmed(indexPath: IndexPath) {
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        let indexPathXX = IndexPath(row: 0, section: 0)
        tableView.deleteRows(at: [indexPathXX], with: .automatic)
        let indexPathX = IndexPath(row: pizzaModel.confirmedOrder.count - 1, section: 1)
        tableView.insertRows(at: [indexPathX], with: .fade)
        pizzaModel.confirmedOrder.remove(at: indexPath.row)
        pizzaModel.confirmedOrder.append(pizzaModel.unconfirmedOrder[0])
        pizzaModel.unconfirmedOrder.remove(at: 0)
        setFormatting()
        tableView.endUpdates()
        
//        pizzaModel.slicesInThisPie -= 1
    }
    
    func removeOneUnconfirmedSlice(indexPath: IndexPath) {
        
        pizzaModel.unconfirmedOrder.remove(at: indexPath.row)
        setFormatting()
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
//        pizzaModel.slicesInThisPie -= 1

    }
    
    func removeConfirmedStatus(indexPath: IndexPath) {
        
        //Take one slice first from the confirmed orders
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        pizzaModel.confirmedOrder.remove(at: indexPath.row)
        setFormatting()
        tableView.endUpdates()
        
//        print("rows in unconfirmed\(tableView.numberOfRows(inSection: 0))")
//        print("rows in confirmed\(tableView.numberOfRows(inSection: 1))")
//        print("pizzaModel.confirmedOrder \(pizzaModel.confirmedOrder)")
//        print("pizzaModel.unconfirmedOrder \(pizzaModel.unconfirmedOrder)")
        
        //Move the 7 remaining slices to the unconfirmed status
        var unconfirmedCounter = 0
        for index in 0..<7 {

            print("index \(index)")
            print("pizzaModel.confirmedOrder.count \(pizzaModel.confirmedOrder.count)")
            print("pizzaModel.unconfirmedOrder.count \(pizzaModel.unconfirmedOrder.count)")
            
            tableView.beginUpdates()
            pizzaModel.unconfirmedOrder.append(pizzaModel.confirmedOrder.last!)
            pizzaModel.confirmedOrder.removeLast()
            
            let rowIndexPathAt = IndexPath(row: (pizzaModel.confirmedOrder.count), section: 1)
            let rowIndexPathTo = IndexPath(row: unconfirmedCounter, section: 0)
            tableView.moveRow(at: rowIndexPathAt, to: rowIndexPathTo)
            
            unconfirmedCounter += 1
            setFormatting()
            tableView.endUpdates()
        }
//        pizzaModel.slicesInThisPie -= 1

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
        
        pizzaModel.slicesInThisPie -= 1
        delegate?.updatePizzaView()
        
        if indexPath.section == 0 { // Unconfirmed Orders chosen to be removed by user
            
            removeOneUnconfirmedSlice(indexPath: indexPath)
//            delegate?.updatePizzaView()
            
        } else { //Confirmed Order chosen to be removed by user
            
            // If unconfirmedOrders arent zero, lets take one from unconfirmed orders
            if pizzaModel.unconfirmedOrder.count != 0 {
                
                removeOneSliceFromUnconfirmed(indexPath: indexPath)
                
            } else { //Unconfirmed orders are zero and we need to take one out from the full pie

                removeConfirmedStatus(indexPath: indexPath)

            }
        }
    }
}


struct OrderFormatted {
    
    var confirmed:String
    var name:[String]
    var amountOfSlices:[String]
}






