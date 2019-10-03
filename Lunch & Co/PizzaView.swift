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
    
    
    var leftCenter = CGPoint()
    var rightCenter = CGPoint()
    var topCenter = CGPoint()
    var bottomCenter = CGPoint()
    
    var topLeft = CGPoint()
    var bottomRight = CGPoint()
    var bottomLeft = CGPoint()
    var topRight = CGPoint()
    
    var pizzaCenter = CGPoint()
    
    var slicesLeft = Int()
    var label:UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, amount: Int) {
        super.init(frame: frame)
        self.slicesLeft = amount
        self.backgroundColor = UIColor.red
        self.layer.cornerRadius = frame.width / 2
        self.clipsToBounds = true
        //        draw(frame, amount: amount)
        
    }
    
    func changeSlices(amount: Int) {
        
        
        
        
        
        
    }
    
    func gradientColors(color1: UIColor, color2: UIColor) {
        
        let gradient = CAGradientLayer()
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient.startPoint = .init(x: 0.0, y: -0.1)
        gradient.endPoint = .init(x: 0.0, y: 1.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient.locations = [0.0, 0.7]
        
        //This keeps the gradient within the bounds of the view
        gradient.frame = bounds
        
        //These are the colors of the gradient(that are being passed in)
        gradient.colors = [color1.cgColor, color2.cgColor]
        
        
        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient, at: 1)
        //        layer.addSublayer(gradient)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        
        leftCenter = CGPoint(x: rect.minX, y: rect.midY)
        rightCenter = CGPoint(x: rect.maxX, y: rect.midY)
        topCenter = CGPoint(x: rect.midX, y: rect.minY)
        bottomCenter = CGPoint(x: rect.midX, y: rect.maxY)
        
        topLeft = CGPoint(x: rect.minX, y: rect.minY)
        bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        topRight = CGPoint(x: rect.maxX, y: rect.minY)
        
        pizzaCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        
        
        //       backgroundColor = UIColor.white
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
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
        
        
        
        
        
        //Remove Slice 1
        
        switch slicesLeft {
            
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
            
            break
            
        default:
            break
        }
    }
}
