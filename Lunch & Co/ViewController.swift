//
//  ViewController.swift
//  Lunch & Co
//
//  Created by Jeffery Widroff on 10/2/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

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
    var pullDownLabel = UILabel()
    
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        infoButton.layer.cornerRadius = infoButton.frame.width / 2
        addPizzaBackGroundView()
        setupPizzaView()
        setUpTextFields()
        createOverlay()
        setTimer()
        addPullDownLabel()
        addPizzaBackGroundView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        dismissKeyBoard()
    }
    
    func addPullDownLabel() {
        
        let width = nameTxtFld.frame.width
        let height = nameTxtFld.frame.height
        let x = (view.frame.width - width) / 2
        let y = activePizzaView.frame.minY - 30
        let frame = CGRect(x: x, y: y, width: width, height: height)
        pullDownLabel.frame = frame
        pullDownLabel.font = UIFont.systemFont(ofSize: 20)
        pullDownLabel.text = "⬇️ PULL DOWN TO REFRESH ⬇️"
        pullDownLabel.textColor = .white
        pullDownLabel.textAlignment = .center
        view.addSubview(pullDownLabel)
    }
    
    func setTimer() {
        
        let timerView = TimerLabel(frame: activePizzaView.frame)
        view.addSubview(timerView)
        timerView.center = view.center
        timerView.center.y = infoButton.center.y
        timerView.delegate = self
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
    
    func addPizzaBackGroundView() {
        
        let x:CGFloat = 0
        let y:CGFloat = 0
        let height = activePizzaView.frame.height
        let width = activePizzaView.frame.width
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let pizzaBackGroundView = UIView(frame: frame)
        pizzaBackGroundView.center = view.center
        pizzaBackGroundView.backgroundColor = UIColor.black
        pizzaBackGroundView.layer.cornerRadius = pizzaBackGroundView.frame.width / 2
        //        pizzaBackGroundView.clipsToBounds = true //MARK: Change this back if you dont like + get rid of the shadow below
        
        pizzaBackGroundView.layer.shadowOpacity = 1
        pizzaBackGroundView.layer.shadowPath = CGPath(rect: pizzaBackGroundView.bounds, transform: nil)
        pizzaBackGroundView.layer.shadowColor = UIColor.white.cgColor
        pizzaBackGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
        pizzaBackGroundView.layer.shadowRadius = 5
        
        let lunchAndCoLabel = UILabel(frame: frame)
        lunchAndCoLabel.textColor = .white
        lunchAndCoLabel.backgroundColor = .clear
        lunchAndCoLabel.text = "Lunch & Co"
        lunchAndCoLabel.font = UIFont.init(name: "snell roundhand", size: 40)
        lunchAndCoLabel.adjustsFontSizeToFitWidth = true
        //        lunchAndCoLabel.font = UIFont.systemFont(ofSize: 50)
        lunchAndCoLabel.textAlignment = .center
        
        view.insertSubview(pizzaBackGroundView, at: 0)
        pizzaBackGroundView.addSubview(lunchAndCoLabel)
    }
    
    
    func setupPizzaView() {
        
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
            // DOWNLOAD FROM THE DATABASE
        default:
            break
        }
    }
    
    func moveWithPan(view: UIView, sender: UIPanGestureRecognizer){

        let translation = sender.translation(in: activePizzaView)
        
        print(translation.y)
        
        if translation.y < 50 && translation.y > 0 {
            activePizzaView.center.y = activePizzaView.center.y + translation.y
            overlayView.alpha = 0
            overlayView.center.y = overlayView.center.y + translation.y
        }
        sender.setTranslation(CGPoint.zero, in: activePizzaView)
    }
    
    func returnViewToOrigin(view: UIView){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.activePizzaView.frame.origin = self.origin
            self.overlayView.frame.origin = self.origin
        }, completion: { (true) in
            self.overlayView.alpha = 1.0
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
        view.insertSubview(finishedPizzaView, at: 2)
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
        
        activePizzaView.removeFromSuperview()
        let oldPizzaView = PizzaView(frame: activePizzaView.frame, amount: pizzaModel.slicesInThisPie)
        oldPizzaView.gradientColors(color1: UIColor.red, color2: UIColor.yellow)
        view.insertSubview(oldPizzaView, at: 1)
        activePizzaView = oldPizzaView
    }
    
    var unconfirmedOrderID = 0
    var confirmedOrderID = 0

    func updateOrder() {
        
        //TODO: Need to get a unique identifier for the children in order to remove them using the infoView
        
        for _ in 1...selectedSlices {
            
            let order = Order(name: nameTxtFld.text ?? "No Name", slices:  1)
            ref?.child("unconfirmed").child("unconfirmedID\(unconfirmedOrderID)").setValue(nameTxtFld.text ?? "No Name")
            pizzaModel.unconfirmedOrder.append(order)
            
            unconfirmedOrderID += 1
            
            if pizzaModel.unconfirmedOrder.count == 8 {
                
                pizzaModel.confirmedOrder += pizzaModel.unconfirmedOrder
                
                for unconfirmedOrder in pizzaModel.unconfirmedOrder {
                    ref?.child("confirmed").child("confirmedID\(confirmedOrderID)").setValue(unconfirmedOrder.name)
                    confirmedOrderID += 1
                }

                unconfirmedOrderID = 0
                ref?.child("unconfirmed").removeValue()
                pizzaModel.unconfirmedOrder = [Order]()
            }
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
        
        pieView.removeFromSuperview()
        slicesShown = 7
        activePizzaView.removeFromSuperview()
        let updatedPizzaView = PizzaView(frame: activePizzaView.frame, amount: slicesShown)
        activePizzaView = updatedPizzaView
        view.insertSubview(updatedPizzaView, at: 1)
        xFloat4CompletedPies -= 50 //So that a pie added after this goes to the correct spot
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        //MARK: Download from the database first
        
        
        updateOrder()
        updatePieView()
        
//        buildOrderList() //Do this all the way at the end after the timer has run out
    }
    
    func updateInfoView() {
        
        //MARK: Download from the database first
        
        let x = view.bounds.midX
        let y = view.bounds.midY
        let width = view.frame.width / 10 * 8
        let height = view.frame.height / 10 * 8
        let infoViewFrame = CGRect(x: x, y: y, width: width, height: height)
        infoView = InfoView(frame: infoViewFrame, pizzaModel: pizzaModel)
        infoView.center = view.center
        infoView.backgroundColor = .black
        infoView.delegate = self
        view.addSubview(infoView)
    }
    
    @IBAction func infoButton(_ sender: UIButton) {

        //MARK: DOWNLOAD FROM THE DATABASE FIRST
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
    
    
    func updateFirebaseDatabase() {
        
        
        var counter = 0
        ref?.child("unconfirmed").removeValue()
        for unconfirmedOrder in pizzaModel.unconfirmedOrder {
            ref?.child("unconfirmed").child("unconfirmedID\(counter)").setValue(unconfirmedOrder.name)
            counter += 1
        }
        
        counter = 0
        
        ref?.child("confirmed").removeValue()
        for confirmedOrder in pizzaModel.confirmedOrder {
            ref?.child("confirmed").child("confirmedID\(counter)").setValue(confirmedOrder.name)
            counter += 1
        }
        
        
        
        
        
        
    }
    
    func downloadFromDatabase() {  //THIS ISNT WORKING
        
        ref?.child("unconfirmed").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let unconfirmedOrders = snapshot.value as! [String : String]
            
            self.pizzaModel.unconfirmedOrder = [Order]()
            
            for unconfirmedOrder in unconfirmedOrders.sorted(by: {$0.key < $1.key}) {
                
                print(unconfirmedOrder.value)
                
                let order = Order(name: unconfirmedOrder.value, slices: 1)
                
                self.pizzaModel.unconfirmedOrder.append(order)
                
            }
        })
        
//        ref?.child("confirmed").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            let confirmedOrders = snapshot.value as! [String : String]
//            
//            self.pizzaModel.confirmedOrder = [Order]()
//            
//            for confirmedOrder in confirmedOrders.sorted(by: {$0.key < $1.key}) {
//                
////                print(confirmedOrder.value)
//                
//                let order = Order(name: confirmedOrder.value, slices: 1)
//
//                self.pizzaModel.confirmedOrder.append(order)
//
//            }
//        })
        
        
        
        
    }
    
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


extension ViewController: UpdateDelegate {
    
    func updateDatabase() {
        
        print("update database")
    }
    
}
