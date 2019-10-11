//
//  ViewController.swift
//  Lunch & Co
//
//  Created by Jeffery Widroff on 10/2/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pizzaView: PizzaView!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var slicesTextField: UITextField!
    @IBOutlet weak var infoButton: UIButton!
    
    var slicesShown = 0
    var selectedSlices = 1
    var slicesInThisPie = 0
    var totalSlices = 0
    var pickerView = UIPickerView()
    var users:[String] = ["JSW", "ME", "AK", "EL", "AS", "YD"]
    var activeTextField = UITextField()
    var activePizzaView = PizzaView()
    var orders = [Order]()
    var confirmedOrder = [Order]()
    var unconfirmedOrder = [Order]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.layer.cornerRadius = infoButton.frame.width / 2
        setupPizzaView()
        setUpTextFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismissKeyBoard()
    }
    
    func setUpTextFields() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        slicesTextField.delegate = self
        nameTxtFld.delegate = self
        
        nameTxtFld.inputView = pickerView
        slicesTextField.inputView = pickerView
        
        users.sort { $0.lowercased() < $1.lowercased() }
    }
    
    @objc func dismissKeyBoard() {
        
        view.endEditing(true)
    }
    
    func setupPizzaView() {
        
        pizzaView.layer.cornerRadius = pizzaView.frame.height / 2
        pizzaView.clipsToBounds = true
        activePizzaView = pizzaView
    }
    
    func updateSlices() {
        
        slicesInThisPie += selectedSlices
        if slicesInThisPie > 8 {
            slicesInThisPie = slicesInThisPie % 8
        }
        totalSlices += selectedSlices
    }
    
    func updatePieView() {

        var originalSlices = (slicesInThisPie) - selectedSlices
        if originalSlices < 0 {
            originalSlices = 8 + originalSlices
        }
        var animationsLeft = selectedSlices
        var counter = 1
        
        print("slicesInThisPie \(slicesInThisPie)")
        print("totalSlices \(totalSlices)")
        print("originalSlices \(originalSlices)")
        
        
        
        if animationsLeft != 0 {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.activePizzaView.removeFromSuperview()
                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                self.activePizzaView = newPizzaView
                self.view.addSubview(self.activePizzaView)
                self.slicesShown += 1
                counter += 1
                animationsLeft -= 1
                if self.slicesShown == 8 {
                    self.animateCompletedPie()
                    self.slicesShown = 0
                    originalSlices = 0
                    counter = 1
                }
            }) { (true) in
                if animationsLeft != 0 {
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        self.activePizzaView.removeFromSuperview()
                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                        self.activePizzaView = newPizzaView
                        self.view.addSubview(self.activePizzaView)
                        self.slicesShown += 1
                        counter += 1
                        animationsLeft -= 1
                        if self.slicesShown == 8 {
                            self.animateCompletedPie()
                            self.slicesShown = 0
                            originalSlices = 0
                            counter = 1
                        }
                    }) { (true) in
                        if animationsLeft != 0 {
                            
                            UIView.animate(withDuration: 0.25, animations: {
                                self.activePizzaView.removeFromSuperview()
                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                self.activePizzaView = newPizzaView
                                self.view.addSubview(self.activePizzaView)
                                self.slicesShown += 1
                                counter += 1
                                animationsLeft -= 1
                                if self.slicesShown == 8 {
                                    self.animateCompletedPie()
                                    self.slicesShown = 0
                                    originalSlices = 0
                                    counter = 1
                                }
                            }) { (true) in
                                if animationsLeft != 0 {
                                    
                                    UIView.animate(withDuration: 0.25, animations: {
                                        self.activePizzaView.removeFromSuperview()
                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                        self.activePizzaView = newPizzaView
                                        self.view.addSubview(self.activePizzaView)
                                        self.slicesShown += 1
                                        counter += 1
                                        animationsLeft -= 1
                                        if self.slicesShown == 8 {
                                            self.animateCompletedPie()
                                            self.slicesShown = 0
                                            originalSlices = 0
                                            counter = 1
                                        }
                                    }) { (true) in
                                        if animationsLeft != 0 {
                                            
                                            UIView.animate(withDuration: 0.25, animations: {
                                                self.activePizzaView.removeFromSuperview()
                                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                self.activePizzaView = newPizzaView
                                                self.view.addSubview(self.activePizzaView)
                                                self.slicesShown += 1
                                                counter += 1
                                                animationsLeft -= 1
                                                if self.slicesShown == 8 {
                                                    self.animateCompletedPie()
                                                    self.slicesShown = 0
                                                    originalSlices = 0
                                                    counter = 1
                                                }
                                            }) { (true) in
                                                if animationsLeft != 0 {
                                                    
                                                    UIView.animate(withDuration: 0.25, animations: {
                                                        self.activePizzaView.removeFromSuperview()
                                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                        self.activePizzaView = newPizzaView
                                                        self.view.addSubview(self.activePizzaView)
                                                        self.slicesShown += 1
                                                        counter += 1
                                                        animationsLeft -= 1
                                                        if self.slicesShown == 8 {
                                                            self.animateCompletedPie()
                                                            self.slicesShown = 0
                                                            originalSlices = 0
                                                            counter = 1
                                                        }
                                                    }) { (true) in
                                                        if animationsLeft != 0 {
                                                            
                                                            UIView.animate(withDuration: 0.25, animations: {
                                                                self.activePizzaView.removeFromSuperview()
                                                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                                self.activePizzaView = newPizzaView
                                                                self.view.addSubview(self.activePizzaView)
                                                                self.slicesShown += 1
                                                                counter += 1
                                                                animationsLeft -= 1
                                                                if self.slicesShown == 8 {
                                                                    self.animateCompletedPie()
                                                                    self.slicesShown = 0
                                                                    originalSlices = 0
                                                                    counter = 1
                                                                }
                                                            }) { (true) in
                                                                if animationsLeft != 0 {
                                                                    
                                                                    UIView.animate(withDuration: 0.25, animations: {
                                                                        self.activePizzaView.removeFromSuperview()
                                                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                                        self.activePizzaView = newPizzaView
                                                                        self.view.addSubview(self.activePizzaView)
                                                                        self.slicesShown += 1
                                                                        counter += 1
                                                                        animationsLeft -= 1
                                                                        if self.slicesShown == 8 {
                                                                            self.animateCompletedPie()
                                                                            self.slicesShown = 0
                                                                            originalSlices = 0
                                                                            counter = 1
                                                                        }
                                                                    }) { (false) in
                                                                        print()
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
//        KEPT THIS IN CASE WE COULDNT FIGURE OUT HOW TO KEEP THE CORNER RADIUS THROUGHOUT THE ANIMATION
//                self.activePizzaView.removeFromSuperview()
//                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: self.slicesInThisPie)
//                self.activePizzaView = newPizzaView
//                self.view.addSubview(self.activePizzaView)
    }
    
    
    
    func animateCompletedPie() {

        let amountToMove = (view.bounds.maxY - activePizzaView.center.y) / 2 * 1.25
        let transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        let newPizzaView = PizzaView(frame: activePizzaView.frame, amount: 0)
        activePizzaView.removeFromSuperview()
        view.addSubview(newPizzaView)
        activePizzaView = newPizzaView
        let finishedPizzaView = PizzaView(frame: activePizzaView.frame, amount: 8)
        view.addSubview(finishedPizzaView)
        UIView.animate(withDuration: 1.0, animations: {
            finishedPizzaView.center.y += amountToMove
            finishedPizzaView.transform = transform
        }) { (true) in
            UIView.animate(withDuration: 1.0) {
                let amountToMoveOnBottom:CGFloat = -200
                finishedPizzaView.center.x += amountToMoveOnBottom
            }
        }
        
        
    }
    
    func updateNewPie() {
        
        let remainder = (slicesInThisPie % 8)
        slicesInThisPie = remainder
        activePizzaView.removeFromSuperview()
        let oldPizzaView = PizzaView(frame: activePizzaView.frame, amount: slicesInThisPie)
        oldPizzaView.gradientColors(color1: UIColor.red, color2: UIColor.yellow)
        view.insertSubview(oldPizzaView, at: 1)
        activePizzaView = oldPizzaView
    }
    
    func updateOrder() {
        
        print(orders.map({$0.name!}),orders.map({$0.slices!}))
        
        for order in orders {
            
            unconfirmedOrder.append(order)
            print(unconfirmedOrder.count)

            if unconfirmedOrder.count == 8 {
                confirmedOrder += unconfirmedOrder
                unconfirmedOrder = [Order]()
            }
        }
        
        orders = [Order]()
    }
    
    func saveUserOrder() {

        for _ in 1...selectedSlices {
            let order = Order(name: nameTxtFld.text ?? "No Name", slices:  1)
            orders.append(order)
        }
    }
    

    func buildOrderList() {
        
        //Need to make this work for incomplete pies
        
        var orderToShow = [Order]()

        print("confirmedOrder \(confirmedOrder.map({$0.name})), \(confirmedOrder.map({$0.slices}))")
        
        
        for order in confirmedOrder {
            
            if !orderToShow.contains(where: { (orderX) -> Bool in
                orderX.name == order.name
            }) {
                
                order.confirmed = true
                orderToShow.append(order)
                
            } else {
                
                for orderX in orderToShow {
                    
                    if orderX.name == order.name {
                        orderX.slices! += 1
                    }
                }
            }
        }
        
        confirmedOrder = orderToShow
        orderToShow = [Order]() //This may not be necessary

        for order in unconfirmedOrder {
            
            if !orderToShow.contains(where: { (orderX) -> Bool in
                orderX.name == order.name
            }) {
                
//                order.confirmed = true
                orderToShow.append(order)
                
            } else {
                
                for orderX in orderToShow {
                    
                    if orderX.name == order.name {
                        orderX.slices! += 1
                    }
                }
            }
        }
        
        unconfirmedOrder = orderToShow
        orderToShow = [Order]()
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        updateSlices() //Sets slicesInThisPie and totalSlices
        saveUserOrder() //Takes the order and turns it into multiple tiny orders... all containing one slice each
        updateOrder()
        updatePieView()
//        buildOrderList()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        
        print("confirmed order \(confirmedOrder.map({$0.name})), \(confirmedOrder.map({$0.slices}))")

        print("unconfirmed order \(unconfirmedOrder.map({$0.name})), \(unconfirmedOrder.map({$0.slices}))")
        
        
        let x = view.bounds.midX
        let y = view.bounds.midY
        let width = view.frame.width / 10 * 8
        let height = view.frame.height / 10 * 8
        let infoViewFrame = CGRect(x: x, y: y, width: width, height: height)
        let infoView = InfoView(frame: infoViewFrame, confirmedOrders: confirmedOrder, unconfirmedOrders: unconfirmedOrder)
        infoView.center = view.center
        infoView.backgroundColor = .green
        view.addSubview(infoView)
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var amount = Int()
        
        if activeTextField == self.nameTxtFld {
            amount = users.count
        }
        
        if activeTextField == self.slicesTextField {
            amount = 8
        }
        
        return amount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var string = String()
        
        if activeTextField == self.nameTxtFld {
            string = "\(users[row])"
        }
        
        if activeTextField == self.slicesTextField {
            string = "\(row + 1)"
        }
        
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if activeTextField == self.nameTxtFld {
            nameTxtFld.text = "\(users[row])"
        }
        
        if activeTextField == self.slicesTextField {
            slicesTextField.text = "\(row + 1) Slice(s)"
            selectedSlices = row + 1
        }
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        
        if textField == self.nameTxtFld {
            nameTxtFld.inputView = pickerView
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyBoard))
            toolBar.setItems([doneButton], animated: true)
            toolBar.isUserInteractionEnabled = true
            textField.inputAccessoryView = toolBar
        }

        if textField == self.slicesTextField {
            slicesTextField.inputView = pickerView
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyBoard))
            toolBar.setItems([doneButton], animated: true)
            toolBar.isUserInteractionEnabled = true
            textField.inputAccessoryView = toolBar
        }
        pickerView.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        dismissKeyBoard()
    }
}


