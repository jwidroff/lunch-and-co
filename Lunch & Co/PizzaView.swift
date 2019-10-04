//
//  PizzaView.swift
//  Lunch & Co
//
//  Created by Jeffery Widroff on 10/2/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class PizzaView: UIView {
    
    //TODO: Add gradient to the pizzaView in the center - like a light orange-ish
    
    //TODO: Need to look up how to draw on top of a CAGradientLayer
    //TODO: Need to figure out how to show the amount on the pickerView when the pickerView is originally called (AKA if the pickerView first lands on "1", the textView should update eventhough I didnt change anything yet)
    
    
    var leftCenter = CGPoint()
    var rightCenter = CGPoint()
    var topCenter = CGPoint()
    var bottomCenter = CGPoint()
    
    var topLeft = CGPoint()
    var bottomRight = CGPoint()
    var bottomLeft = CGPoint()
    var topRight = CGPoint()
    
    var pizzaCenter = CGPoint()
    
    var slicesToShow = Int()
    var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, amount: Int) {
        super.init(frame: frame)
        self.slicesToShow = amount
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = frame.width / 2
        gradientColors(color1: .red, color2: .yellow)
        let slicesView = SlicesView(frame: bounds, slicesToShow: slicesToShow)
        addSubview(slicesView)
        print("L")
    }
    
    func gradientColors(color1: UIColor, color2: UIColor) {
        
        let gradient = CAGradientLayer()
        gradient.startPoint = .init(x: 0.0, y: -0.1)
        gradient.endPoint = .init(x: 0.0, y: 1.0)
        gradient.locations = [-0.1, 0.55, 1.1]
        gradient.frame = bounds
        gradient.colors = [color1.cgColor, color2.cgColor, color1.cgColor]
        layer.insertSublayer(gradient, at: 1)
        
        let gradient2 = CAGradientLayer()
        gradient2.startPoint = .init(x: -0.1, y: 0.0)
        gradient2.endPoint = .init(x: 1.0, y: 0.0)
        gradient2.locations = [-0.1, 0.55, 1.1]
        gradient2.frame = bounds
        gradient2.colors = [color1.cgColor, UIColor.clear.cgColor, color1.cgColor]
        layer.insertSublayer(gradient2, at: 1)
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}



class SlicesView: UIView {
    
    var slicesToShow = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, slicesToShow: Int) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.slicesToShow = slicesToShow
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        let leftCenter = CGPoint(x: bounds.minX, y: bounds.midY)
        let rightCenter = CGPoint(x: bounds.maxX, y: bounds.midY)
        let topCenter = CGPoint(x: bounds.midX, y: bounds.minY)
        let bottomCenter = CGPoint(x: bounds.midX, y: bounds.maxY)
        let topLeft = CGPoint(x: bounds.minX, y: bounds.minY)
        let bottomRight = CGPoint(x: bounds.maxX, y: bounds.maxY)
        let bottomLeft = CGPoint(x: bounds.minX, y: bounds.maxY)
        let topRight = CGPoint(x: bounds.maxX, y: bounds.minY)
        let pizzaCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        context.setLineWidth(5)
        context.setStrokeColor(UIColor.black.cgColor)
        
        context.beginPath()
        context.move(to: leftCenter)
        context.addLine(to: rightCenter)
        context.strokePath()
        
        context.beginPath()
        context.move(to: topCenter)
        context.addLine(to: bottomCenter)
        context.strokePath()
        
        context.beginPath()
        context.move(to: topLeft)
        context.addLine(to: bottomRight)
        context.strokePath()
        
        context.beginPath()
        context.move(to: bottomLeft)
        context.addLine(to: topRight)
        context.strokePath()
        
        switch slicesToShow {
            
        case 7:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 6:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topCenter)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 5:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 4:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: rightCenter)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 3:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 2:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomCenter)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
        case 1:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomLeft)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
            
        case 0:
            context.beginPath()
            context.move(to: bottomLeft)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(UIColor.black.cgColor)
            context.fillPath()
            
        default:
            break
        }
    }
}
