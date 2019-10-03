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
    var pickerView = UIPickerView()
    var users:[String] = ["JSW", "ME", "AK", "EL", "AS", "YD"]
    var activeTextField = UITextField()
    
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
        
        

        nameTxtFld.inputView = pickerView
        slicesTextField.inputView = pickerView
        
        
        slicesTextField.delegate = self
        nameTxtFld.delegate = self

//        let toolBar1 = UIToolbar()
//        toolBar1.sizeToFit()
//        let doneButton1 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyBoard))
//        toolBar1.setItems([doneButton1], animated: true)
//        toolBar1.isUserInteractionEnabled = true
//
//        let toolBar2 = UIToolbar()
//        toolBar2.sizeToFit()
//        let doneButton2 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyBoard))
//        toolBar2.setItems([doneButton2], animated: true)
//        toolBar2.isUserInteractionEnabled = true
//        nameTxtFld.inputView = toolBar1
//        slicesTextField.inputView = toolBar2
    }
    
    @objc func dismissKeyBoard() {
        
        view.endEditing(true)
    }
    
    
    func setupPizzaView() {
        
        pizzaView.layer.cornerRadius = pizzaView.frame.height / 2
        pizzaView.clipsToBounds = true
    }
    
    
    

    @IBAction func submitPressed(_ sender: Any) {
        
        
        
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
        }

        if textField == self.slicesTextField {
            slicesTextField.inputView = pickerView
        }
        pickerView.reloadAllComponents()

//        textField.reloadInputViews()


    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        dismissKeyBoard()
        
        
    }
    
}


