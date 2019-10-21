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
//    var slicesInThisPie = 0 //
//    var totalSlices = 0 //
    var pickerView = UIPickerView()
    var overlayView = UIView()
//    var users:[String] = ["JSW", "ME", "AK", "EL", "AS", "YD"] //
    var activeTextField = UITextField()
    var activePizzaView = PizzaView()
//    var orders = [Order]() //
//    var confirmedOrder = [Order]() //
//    var unconfirmedOrder = [Order]() //
    var pizzaModel = PizzaModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.layer.cornerRadius = infoButton.frame.width / 2
        setupPizzaView()
        setUpTextFields()
        createOverlay()
        setTimer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismissKeyBoard()
    }
    
    func setupModel() {
        
        
        
    }
    
    func setTimer() {
        
        let timerView = TimerLabel(frame: pizzaView.frame)
        view.addSubview(timerView)
        timerView.center = view.center
        timerView.center.y = infoButton.center.y
        
    }
    
    func setUpTextFields() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        slicesTextField.delegate = self
        nameTxtFld.delegate = self
        
        nameTxtFld.inputView = pickerView
        slicesTextField.inputView = pickerView
        
        pizzaModel.users.sort { $0.lowercased() < $1.lowercased() }
    }
    
    @objc func dismissKeyBoard() {
        
        view.endEditing(true)
    }
    
    func setupPizzaView() {
        
        addPizzaPlateView()
        pizzaView.layer.cornerRadius = pizzaView.frame.height / 2
        pizzaView.clipsToBounds = true
        activePizzaView = pizzaView
    }
    
    func addPizzaPlateView() {
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let height = pizzaView.frame.height
        let width = pizzaView.frame.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        let pizzaPlateView = UIView(frame: frame)
        pizzaPlateView.center = view.center
        pizzaPlateView.backgroundColor = UIColor.darkGray
        pizzaPlateView.layer.cornerRadius = pizzaPlateView.frame.width / 2
        pizzaPlateView.clipsToBounds = true
        view.insertSubview(pizzaPlateView, at: 1)
    }
    
    func updateSlices() {
        
        pizzaModel.slicesInThisPie += selectedSlices
        if pizzaModel.slicesInThisPie > 8 {
            pizzaModel.slicesInThisPie = pizzaModel.slicesInThisPie % 8
        }
//        totalSlices += selectedSlices
    }
    
    func createOverlay() {
        
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let height = pizzaView.frame.height
        let width = pizzaView.frame.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black
        let xOffset = pizzaView.frame.width / 2
        let yOffset = pizzaView.frame.height / 2
        let radius = pizzaView.frame.height / 2
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = .evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        overlayView.center = view.center
        
        view.insertSubview(overlayView, at: 2)
    }
    
    func updatePieView() {

        var originalSlices = (pizzaModel.slicesInThisPie) - selectedSlices
        if originalSlices < 0 {
            originalSlices = 8 + originalSlices
        }
        var animationsLeft = selectedSlices
        var counter = 1
        
//        print("slicesInThisPie \(slicesInThisPie)")
//        print("totalSlices \(totalSlices)")
//        print("originalSlices \(originalSlices)")
        
        
        
        if animationsLeft != 0 {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.activePizzaView.removeFromSuperview()
                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                self.activePizzaView = newPizzaView
                self.view.insertSubview(self.activePizzaView, at: 1)
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
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.activePizzaView.removeFromSuperview()
                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                        self.activePizzaView = newPizzaView
                        self.view.insertSubview(self.activePizzaView, at: 1)
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
                            
                            UIView.animate(withDuration: 0.1, animations: {
                                self.activePizzaView.removeFromSuperview()
                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                self.activePizzaView = newPizzaView
                                self.view.insertSubview(self.activePizzaView, at: 1)
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
                                    
                                    UIView.animate(withDuration: 0.1, animations: {
                                        self.activePizzaView.removeFromSuperview()
                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                        self.activePizzaView = newPizzaView
                                        self.view.insertSubview(self.activePizzaView, at: 1)
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
                                            
                                            UIView.animate(withDuration: 0.1, animations: {
                                                self.activePizzaView.removeFromSuperview()
                                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                self.activePizzaView = newPizzaView
                                                self.view.insertSubview(self.activePizzaView, at: 1)
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
                                                    
                                                    UIView.animate(withDuration: 0.1, animations: {
                                                        self.activePizzaView.removeFromSuperview()
                                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                        self.activePizzaView = newPizzaView
                                                        self.view.insertSubview(self.activePizzaView, at: 1)
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
                                                            
                                                            UIView.animate(withDuration: 0.1, animations: {
                                                                self.activePizzaView.removeFromSuperview()
                                                                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                                self.activePizzaView = newPizzaView
                                                                self.view.insertSubview(self.activePizzaView, at: 1)
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
                                                                    
                                                                    UIView.animate(withDuration: 0.1, animations: {
                                                                        self.activePizzaView.removeFromSuperview()
                                                                        let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                                                                        self.activePizzaView = newPizzaView
                                                                        self.view.insertSubview(self.activePizzaView, at: 1)
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
    
    var xFloat4CompletedPies:CGFloat = -200
    var yFloat4CompletedPies:CGFloat = 0
    
    func animateCompletedPie() {

        var amountToMove = CGFloat()
        
        if xFloat4CompletedPies == 150 {
            yFloat4CompletedPies += 100
            amountToMove = (view.bounds.maxY - activePizzaView.center.y) / 2 * 1.25 + yFloat4CompletedPies
            xFloat4CompletedPies = -200
        } else {
            amountToMove = (view.bounds.maxY - activePizzaView.center.y) / 2 * 1.25 + yFloat4CompletedPies
        }
        
        let transform = CGAffineTransform.identity.scaledBy(x: 0.25, y: 0.25)
//        let identity = CGAffineTransform.identity
//        let rotate = CGAffineTransform.identity.rotated(by: 90.0)
        let newPizzaView = PizzaView(frame: activePizzaView.frame, amount: 0)
        activePizzaView.removeFromSuperview()
        view.insertSubview(newPizzaView, at: 1)
        activePizzaView = newPizzaView
        let finishedPizzaView = PizzaView(frame: activePizzaView.frame, amount: 8)
        view.addSubview(finishedPizzaView)
        UIView.animate(withDuration: 1.0, animations: {
            
            finishedPizzaView.center.y += amountToMove
            finishedPizzaView.transform = transform
            
        }) { (true) in
            
            UIView.animate(withDuration: 1.0) {
                let amountToMoveOnBottom:CGFloat = self.xFloat4CompletedPies
                finishedPizzaView.center.x += amountToMoveOnBottom
//                finishedPizzaView.transform = rotate
            }
        }
        xFloat4CompletedPies += 50
    }
    
    func updateNewPie() {
        
        let remainder = (pizzaModel.slicesInThisPie % 8)
        pizzaModel.slicesInThisPie = remainder
        activePizzaView.removeFromSuperview()
        let oldPizzaView = PizzaView(frame: activePizzaView.frame, amount: pizzaModel.slicesInThisPie)
        oldPizzaView.gradientColors(color1: UIColor.red, color2: UIColor.yellow)
        view.insertSubview(oldPizzaView, at: 1)
        activePizzaView = oldPizzaView
    }
    
    func updateOrder() {
        
//        print(orders.map({$0.name!}),orders.map({$0.slices!}))
        
        for order in pizzaModel.orders {
            
            pizzaModel.unconfirmedOrder.append(order)
//            print(unconfirmedOrder.count)

            if pizzaModel.unconfirmedOrder.count == 8 {
                pizzaModel.confirmedOrder += pizzaModel.unconfirmedOrder
                pizzaModel.unconfirmedOrder = [Order]()
            }
            for order in pizzaModel.confirmedOrder {
                order.confirmed = true
            }
        }
        
        pizzaModel.orders = [Order]()
    }
    
    func divideOrder() {

        for _ in 1...selectedSlices {
            let order = Order(name: nameTxtFld.text ?? "No Name", slices:  1)
            pizzaModel.orders.append(order)
        }
    }
    

    func buildOrderList() {
        
        //Need to make this work for incomplete pies
        
        var orderToShow = [Order]()

//        print("confirmedOrder \(confirmedOrder.map({$0.name})), \(confirmedOrder.map({$0.slices}))")
        
        for order in pizzaModel.confirmedOrder {
            
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
        
        pizzaModel.confirmedOrder = orderToShow
        orderToShow = [Order]() //This may not be necessary

        for order in pizzaModel.unconfirmedOrder {
            
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
        
        pizzaModel.unconfirmedOrder = orderToShow
        orderToShow = [Order]()
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        updateSlices() //Sets slicesInThisPie and totalSlices
        divideOrder() //Takes the order and turns it into multiple tiny orders... all containing one slice each
        updateOrder()
        updatePieView()
        
//        buildOrderList() //Do this all the way at the end. Keep the slices separate in order to allow a user to cancel his/her order and therefore be able to build the new list better (And add slices back if necessary)
        
    }
    
    func updateInfoView() {
        let x = view.bounds.midX
        let y = view.bounds.midY
        let width = view.frame.width / 10 * 8
        let height = view.frame.height / 10 * 8
        let infoViewFrame = CGRect(x: x, y: y, width: width, height: height)
        let infoView = InfoView(frame: infoViewFrame, pizzaModel: pizzaModel)
        infoView.center = view.center
        infoView.backgroundColor = .green
        view.addSubview(infoView)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        
//        print("confirmed order \(confirmedOrder.map({$0.name})), \(confirmedOrder.map({$0.slices}))")

        updateInfoView()

        
//        print("unconfirmed order \(unconfirmedOrder.map({$0.name})), \(unconfirmedOrder.map({$0.slices}))")
        
        
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var amount = Int()
        
        if activeTextField == self.nameTxtFld {
            amount = pizzaModel.users.count
        }
        
        if activeTextField == self.slicesTextField {
            amount = 8
        }
        
        return amount
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var string = String()
        
        if activeTextField == self.nameTxtFld {
            string = "\(pizzaModel.users[row])"
        }
        
        if activeTextField == self.slicesTextField {
            string = "\(row + 1)"
        }
        
        return string
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if activeTextField == self.nameTxtFld {
            nameTxtFld.text = "\(pizzaModel.users[row])"
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
    
    func remove1Slice() {
        
        
        
        
    }
    
}

extension ViewController: CellDelegate {
    
    
    func updateOrder(orderToRemove: Order, confirmed: Bool) {
        
        
        remove1Slice()
        
        
        //update the slices
        
        //figure out what s/b confirmed and what shouldnt
        
        
    }
    
    
    
    
}
