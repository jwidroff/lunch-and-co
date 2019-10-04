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
    
    var selectedSlices = 1
    var slicesInThisPie = 0
    var totalSlices = 0
    var pickerView = UIPickerView()
    var users:[String] = ["JSW", "ME", "AK", "EL", "AS", "YD"]
    var activeTextField = UITextField()
    var activePizzaView = PizzaView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        totalSlices += selectedSlices
    }
    
    func updateSamePie() {
        
        activePizzaView.removeFromSuperview()
        let newPizzaView = PizzaView(frame: activePizzaView.frame, amount: slicesInThisPie)
        activePizzaView = newPizzaView
        view.addSubview(activePizzaView)
    }
    
    func animateCompletedPie() {
        
        let amountToMove = (view.bounds.maxY - activePizzaView.center.y) / 2 * 1.25
        let transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        
        let newPizzaView = PizzaView(frame: activePizzaView.frame, amount: 8)
        view.addSubview(newPizzaView)
        
        
        UIView.animate(withDuration: 1.0, animations: {
            newPizzaView.center.y += amountToMove
            newPizzaView.transform = transform
        }) { (true) in
            UIView.animate(withDuration: 1.0) {
                let amountToMoveOnBottom:CGFloat = -200
                newPizzaView.center.x += amountToMoveOnBottom
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
    
    @IBAction func submitPressed(_ sender: Any) {
        
        updateSlices()
        
        if slicesInThisPie < 8 {
            updateSamePie()
        } else {
            animateCompletedPie()
            updateNewPie()
        }
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


