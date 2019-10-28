//
//  PizzaView.swift
//  Lunch & Co
//
//  Created by Jeffery Widroff on 10/2/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class PizzaView: UIView {
    
    //TODO: Need to set up userDefaults
    //TODO: Need to refresh the pizzaView and timer by pulling down on views
    //TODO: set up error handler
    
    var leftCenter = CGPoint()
    var rightCenter = CGPoint()
    var topCenter = CGPoint()
    var bottomCenter = CGPoint()
    var topLeft = CGPoint()
    var bottomRight = CGPoint()
    var bottomLeft = CGPoint()
    var topRight = CGPoint()
    var pizzaCenter = CGPoint()
    var slicesToShow = Int() // S/b slices in this pie
    var label:UILabel?
    var overlayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, amount: Int) {
        
        super.init(frame: frame)
        slicesToShow = amount
        backgroundColor = UIColor.clear
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        gradientColors(color1: .yellow, color2: .red)
        let slicesView = SlicesView(frame: bounds, slicesToShow: slicesToShow)
        addSubview(slicesView)
    }
    
    
    func gradientColors(color1: UIColor, color2: UIColor) {
        
        let gradient = CAGradientLayer()
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 0.0, y: 1.0)
        gradient.locations = [-0.5, 0.5, 1.5]
        gradient.frame = bounds
        gradient.colors = [color1.cgColor, color2.cgColor, color1.cgColor]
        layer.insertSublayer(gradient, at: 1)
        
        let gradient2 = CAGradientLayer()
        gradient2.startPoint = .init(x: 0.0, y: 0.0)
        gradient2.endPoint = .init(x: 1.0, y: 0.0)
        gradient2.locations = [-0.5, 0.5, 1.5]
        gradient2.frame = bounds
        gradient2.colors = [color1.cgColor, UIColor.clear.cgColor, color1.cgColor]
        layer.insertSublayer(gradient2, at: 1)
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}



class SlicesView: UIView {
    
    var slicesToShow = Int()
    let colorTheme = UIColor.darkGray

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, slicesToShow: Int) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.slicesToShow = slicesToShow
    }
    
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
        
        context.setLineWidth(3)
        context.setStrokeColor(colorTheme.cgColor)
        
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
        
        let eclipseHeight = frame.height / 10 * 9
        let eclipseWidth = frame.width / 10 * 9
        let x = (frame.width - eclipseWidth) / 2
        let y = (frame.height - eclipseHeight) / 2
        let rect = CGRect(x: x, y: y, width: eclipseWidth, height: eclipseHeight)
        
        context.setLineWidth(1)
        context.addEllipse(in: rect)
        context.strokePath()
        
        switch slicesToShow {
            
        case 7:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 6:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topCenter)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 5:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 4:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: rightCenter)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 3:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 2:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomCenter)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
        case 1:
            context.beginPath()
            context.move(to: leftCenter)
            context.addLine(to: pizzaCenter)
            context.addLine(to: bottomLeft)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
            
        case 0:
            context.beginPath()
            context.move(to: bottomLeft)
            context.addLine(to: bottomRight)
            context.addLine(to: topRight)
            context.addLine(to: topLeft)
            context.setFillColor(colorTheme.cgColor)
            context.fillPath()
            
        default:
            break
        }
    }
}
