//
//  ViewController.swift
//  Lunch & Co
//
//  Created by Jeffery Widroff on 10/2/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    @IBOutlet weak var pizzaView: PizzaView!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var slicesTextField: UITextField!
    @IBOutlet weak var infoButton: UIButton!
    
    var slicesShown = 0
    var selectedSlices = 1
    var pickerView = UIPickerView()
    var overlayView = UIView()
    var activeTextField = UITextField()
    var activePizzaView = PizzaView()
    var pizzaModel = PizzaModel()
    var finishedPieViews = [UIView]()
    var infoView = InfoView()
    var origin = CGPoint()
    
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
    
    func setTimer() {
        
        let timerView = TimerLabel(frame: activePizzaView.frame)
        view.addSubview(timerView)
        timerView.center = view.center
        timerView.center.y = infoButton.center.y
    }
    
    func setUpTextFields() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        slicesTextField.delegate = self
        slicesTextField.inputView = pickerView
        nameTxtFld.delegate = self
        nameTxtFld.inputView = pickerView
        
        pizzaModel.users.sort { $0.lowercased() < $1.lowercased() }
    }
    
    @objc func dismissKeyBoard() {
        
        view.endEditing(true)
    }
    
    func refreshInfo() {
        
        //TODO: Need to set up a refresh func to refresh the app with new data
        
        
        
        
    }
    
    func addPizzaPlateView() {
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let height = activePizzaView.frame.height
        let width = activePizzaView.frame.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let pizzaPlateView = UIView(frame: frame)
        pizzaPlateView.center = view.center
        pizzaPlateView.backgroundColor = UIColor.white
//        pizzaPlateView.layer.cornerRadius = pizzaPlateView.frame.width / 2
        pizzaPlateView.clipsToBounds = true
        view.insertSubview(pizzaPlateView, at: 1)
    }
    
    
    func setupPizzaView() {
        
//        addPizzaPlateView()
        
        let widthAndHeight = nameTxtFld.frame.width
        let x = (view.frame.width - widthAndHeight) / 2
        let y = (view.frame.height - widthAndHeight) / 2
        let frame = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
        let pizzaView = PizzaView(frame: frame, amount: 0)
        pizzaView.layer.cornerRadius = pizzaView.frame.height / 2
        pizzaView.clipsToBounds = true
        view.insertSubview(pizzaView, at: 1)
        activePizzaView = pizzaView
        
        origin = activePizzaView.frame.origin
//        addPanGesture(view: pizzaPlateView)
    }
    
    
    func updateSlices() {
        
        pizzaModel.slicesInThisPie += selectedSlices
        if pizzaModel.slicesInThisPie > 8 {
            pizzaModel.slicesInThisPie = pizzaModel.slicesInThisPie % 8
        }
    }
    
    func createOverlay() {
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let height = activePizzaView.frame.height
        let width = activePizzaView.frame.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        overlayView = UIView(frame: frame)
        overlayView.backgroundColor = UIColor.black
        let xOffset = activePizzaView.frame.width / 2
        let yOffset = activePizzaView.frame.height / 2
        let radius = activePizzaView.frame.height / 2
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
        
//        overlayView.isUserInteractionEnabled = true
        
        addPanGesture()
        
        view.insertSubview(overlayView, at: 2)
    }
    
    func addPanGesture() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(PizzaView.handlePan(sender:)))
        
        overlayView.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender:UIPanGestureRecognizer){
        
        switch sender.state {
        case .changed://, .changed:
            moveWithPan(view: overlayView, sender: sender)
        case .ended:
            returnViewToOrigin(view: overlayView)
        default:
            break
        }
    }
    
    func moveWithPan(view: UIView, sender: UIPanGestureRecognizer){
        
        
        
        let translation = sender.translation(in: activePizzaView)
        
        print(translation.y)
        
        if translation.y < 50 && translation.y > 0 {//}|| translation.y < 0 {
//            view.center.y = (origin.y + 150)
//            activePizzaView.center.y = view.center.y
//            activePizzaView.center.y = (origin.y + 150)
            
            
//            activePizzaView.center.y = (activePizzaView.center.y + 50)
//            overlayView.center.y = (overlayView.center.y + 50)
            
            activePizzaView.center.y = activePizzaView.center.y + translation.y
            overlayView.center.y = overlayView.center.y + translation.y
            
        } else if translation.y < 0{
            
//            activePizzaView.center.y = (origin.y)
//            overlayView.center.y = (origin.y)

        } else {
//            view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
            
            
            
            
//            activePizzaView.center.y = activePizzaView.center.y + translation.y
//            overlayView.center.y = overlayView.center.y + translation.y
        }
        sender.setTranslation(CGPoint.zero, in: activePizzaView)
        
    }
    
    func returnViewToOrigin(view: UIView){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.activePizzaView.frame.origin = self.origin
            self.overlayView.frame.origin = self.origin
            
        })
    }
    
    
    func updatePieView() {
        
        var originalSlices = (pizzaModel.slicesInThisPie) - selectedSlices
        if originalSlices < 0 {
            originalSlices = 8 + originalSlices
        }
        var animationsLeft = selectedSlices
        var counter = 1
        
        if animationsLeft != 0 {
            
            UIView.animate(withDuration: 0.1, animations: {
                self.activePizzaView.removeFromSuperview()
                let newPizzaView = PizzaView(frame: self.activePizzaView.frame, amount: originalSlices + counter)
                self.activePizzaView = newPizzaView
                self.view.insertSubview(self.activePizzaView, at: 1)
                self.slicesShown += 1
                self.activePizzaView.isUserInteractionEnabled = true
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
        let newPizzaView = PizzaView(frame: activePizzaView.frame, amount: 0)
        activePizzaView.removeFromSuperview()
        view.insertSubview(newPizzaView, at: 1)
        activePizzaView = newPizzaView
        let finishedPizzaView = PizzaView(frame: activePizzaView.frame, amount: 8)
        view.insertSubview(finishedPizzaView, at: 1)
        finishedPieViews.append(finishedPizzaView)
        UIView.animate(withDuration: 1.0, animations: {
            
            finishedPizzaView.center.y += amountToMove
            finishedPizzaView.transform = transform
            
        }) { (true) in
            
            UIView.animate(withDuration: 1.0) {
                let amountToMoveOnBottom:CGFloat = self.xFloat4CompletedPies
                finishedPizzaView.center.x += amountToMoveOnBottom
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
        
        for order in pizzaModel.orders {
            
            pizzaModel.unconfirmedOrder.append(order)

            if pizzaModel.unconfirmedOrder.count == 8 {
                pizzaModel.confirmedOrder += pizzaModel.unconfirmedOrder
                pizzaModel.unconfirmedOrder = [Order]()
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
        //TODO: Add this
        
        
        var orderToShow = [Order]()
        
        for order in pizzaModel.confirmedOrder {
            
            if !orderToShow.contains(where: { (orderX) -> Bool in
                orderX.name == order.name
            }) {
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
    
    func removeOneSliceFromActivePizzaView() {
        
        slicesShown -= 1
        activePizzaView.removeFromSuperview()
        let updatedPizzaView = PizzaView(frame: activePizzaView.frame, amount: slicesShown)
        activePizzaView = updatedPizzaView
        view.insertSubview(updatedPizzaView, at: 1)
    }
    
    func removeFinishedPizzaView(pieView: UIView) {
        
        //TODO: This seems to not work anymore. Fix this. Seems like slicesShown may be the issue
        
        print("HI")
        print(slicesShown)
        
        pieView.removeFromSuperview()
        slicesShown = 7
        activePizzaView.removeFromSuperview()
        let updatedPizzaView = PizzaView(frame: activePizzaView.frame, amount: slicesShown)
        activePizzaView = updatedPizzaView
        view.insertSubview(updatedPizzaView, at: 1)
        xFloat4CompletedPies -= 50 //So that a pie added after this goes to the correct spot
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        updateSlices() //Sets slicesInThisPie and totalSlices
        divideOrder() //Takes the order and turns it into multiple tiny orders... all containing one slice each
        updateOrder()
        updatePieView()
        
//        buildOrderList() //Do this all the way at the end after the timer has run out
        
    }
    
    func updateInfoView() {
        
        let x = view.bounds.midX
        let y = view.bounds.midY
        let width = view.frame.width / 10 * 8
        let height = view.frame.height / 10 * 8
        let infoViewFrame = CGRect(x: x, y: y, width: width, height: height)
        infoView = InfoView(frame: infoViewFrame, pizzaModel: pizzaModel)
        infoView.center = view.center
        infoView.backgroundColor = .green
        infoView.delegate = self
        view.addSubview(infoView)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {

        updateInfoView()
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
            
            var sliceOrSlicesText = "Slices"
            
            if row == 0 {
                
                sliceOrSlicesText = "Slice"
            }
            slicesTextField.text = "\(row + 1) \(sliceOrSlicesText)"
            selectedSlices = row + 1
        }
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
        
        if textField == self.nameTxtFld {
            nameTxtFld.inputView = pickerView
            nameTxtFld.text = pizzaModel.users.first
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyBoard))
            toolBar.setItems([doneButton], animated: true)
            toolBar.isUserInteractionEnabled = true
            textField.inputAccessoryView = toolBar
        }

        if textField == self.slicesTextField {
            slicesTextField.inputView = pickerView
            slicesTextField.text = "1 Slice"
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


extension ViewController: CellDelegate {
    
    func updatePizzaView() {
        
        if slicesShown == 0 {
            
            if let pieView = finishedPieViews.last {
                
                print(pieView.center)
                
                // Since slices shown are zero, first check to see if theres a pie view and if there is, remove it
                removeFinishedPizzaView(pieView: pieView)

            } else {
                
                // Since theres no pieView, reduce the current pie view by one
                removeOneSliceFromActivePizzaView()
            }
            
        } else {
            
            //Because there are still slices remaining in the current pieView, remove 1 slice from the current pieView
            removeOneSliceFromActivePizzaView()
        }
    }
}
