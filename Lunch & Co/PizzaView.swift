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
    //TODO: Save all data and make calculations etc when the timer runs to Zero
    //TODO: Need to show a breakdown of what people owe
    //TODO: App needs to try to pull information on start up every time
    
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
//    var overlayView = UIView()
    var origin = CGPoint()
    
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
        gradientColors(color1: .red, color2: .yellow)
        
        let slicesView = SlicesView(frame: bounds, slicesToShow: slicesToShow)
        insertSubview(slicesView, at: 2)
        let pepperoniView = PepperoniView(frame: bounds)
        insertSubview(pepperoniView, at: 2)
        
        
        origin = self.frame.origin
//        addPanGesture()
//        createOverlay()
    }
    
//    func createOverlay() {
//
//        let x:CGFloat = 0
//        let y:CGFloat = 0
//        let height = self.frame.height
//        let width = self.frame.width
//        let frame = CGRect(x: x, y: y, width: width, height: height)
//        overlayView = UIView(frame: frame)
//        overlayView.backgroundColor = UIColor.black
//        let xOffset = frame.width / 2
//        let yOffset = frame.height / 2
//        let radius = frame.height / 2
//        let path = CGMutablePath()
//        path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius, startAngle: 0.0, endAngle: 2.0 * .pi, clockwise: false)
//        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.path = path
//        maskLayer.fillRule = .evenOdd
//
//        overlayView.layer.mask = maskLayer
//        overlayView.clipsToBounds = true
//        overlayView.center = center
//
//        //        overlayView.isUserInteractionEnabled = true
//
//        //        addPanGesture(view: overlayView)
//
//        insertSubview(overlayView, at: 2)
//    }
    
    func addPanGesture() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(PizzaView.handlePan(sender:)))
        
        self.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender:UIPanGestureRecognizer){
        
        switch sender.state {
        case .changed://, .changed:
            moveWithPan(view: self, sender: sender)
        case .ended:
            returnViewToOrigin(view: self)
        default:
            break
        }
    }

    func moveWithPan(view: UIView, sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: view)
        
        print(translation.y)
        
        if translation.y > 50 || translation.y < 0 {
            view.center.y = (origin.y + 150)
        } else {
            view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
        
    }
    
    func returnViewToOrigin(view: UIView){
        
        UIView.animate(withDuration: 0.25, animations: {self.frame.origin = self.origin})
        
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

class PepperoniView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        context.setFillColor(UIColor.red.cgColor)
        context.setLineWidth(1)
        let eclipseHeight = frame.height / 8
        let eclipseWidth = frame.width / 8
        let fraction = ((frame.width - eclipseWidth) / 16)
        let spot1 = CGPoint(x: fraction * 6.5, y: fraction * 4.5)
        let spot2 = CGPoint(x: fraction * 4.5, y: fraction * 6.5)
        let spot3 = CGPoint(x: fraction * 9.5, y: fraction * 11.5)
        let spot4 = CGPoint(x: fraction * 11.5 , y: fraction * 9.5)
        let spot5 = CGPoint(x: fraction * 11.5 , y: fraction * 6.5)
        let spot6 = CGPoint(x: fraction * 6.5 , y: fraction * 11.5)
        let spot7 = CGPoint(x: fraction * 4.5, y: fraction * 9.5)
        let spot8 = CGPoint(x: fraction * 9.5, y: fraction * 4.5)
        let spot9 = CGPoint(x: fraction * 4.25, y: fraction * 13.75)
        let spot10 = CGPoint(x: fraction * 6.75, y: fraction * 14.75)
        let spot11 = CGPoint(x: fraction * 13.75, y: fraction * 4.25)
        let spot12 = CGPoint(x: fraction * 14.75, y: fraction * 6.75)
        let spot13 = CGPoint(x: fraction * 9.25, y: fraction * 14.75)
        let spot14 = CGPoint(x: fraction * 11.75, y: fraction * 13.75)
        let spot15 = CGPoint(x: fraction * 2.25, y: fraction * 4.25)
        let spot16 = CGPoint(x: fraction * 1.25, y: fraction * 6.75)
        let spot17 = CGPoint(x: fraction * 4.25, y: fraction * 2.25)
        let spot18 = CGPoint(x: fraction * 6.75, y: fraction * 1.25)
        let spot19 = CGPoint(x: fraction * 11.75, y: fraction * 2.25)
        let spot20 = CGPoint(x: fraction * 9.25, y: fraction * 1.25)
        let spot21 = CGPoint(x: fraction * 1.25, y: fraction * 9.25)
        let spot22 = CGPoint(x: fraction * 2.25, y: fraction * 11.75)
        let spot23 = CGPoint(x: fraction * 13.75, y: fraction * 11.75)
        let spot24 = CGPoint(x: fraction * 14.75, y: fraction * 9.25)
        let spot25 = CGPoint(x: fraction * 8, y: fraction * 8)



        let rect1 = CGRect(x: spot1.x, y: spot1.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect1)
        context.fillEllipse(in: rect1)

        let rect2 = CGRect(x: spot2.x, y: spot2.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect2)
        context.fillEllipse(in: rect2)

        let rect3 = CGRect(x: spot3.x, y: spot3.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect3)
        context.fillEllipse(in: rect3)

        let rect4 = CGRect(x: spot4.x, y: spot4.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect4)
        context.fillEllipse(in: rect4)

        let rect5 = CGRect(x: spot5.x, y: spot5.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect5)
        context.fillEllipse(in: rect5)

        let rect6 = CGRect(x: spot6.x, y: spot6.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect6)
        context.fillEllipse(in: rect6)

        let rect7 = CGRect(x: spot7.x, y: spot7.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect7)
        context.fillEllipse(in: rect7)

        let rect8 = CGRect(x: spot8.x, y: spot8.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect8)
        context.fillEllipse(in: rect8)

        let rect9 = CGRect(x: spot9.x, y: spot9.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect9)
        context.fillEllipse(in: rect9)

        let rect10 = CGRect(x: spot10.x, y: spot10.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect10)
        context.fillEllipse(in: rect10)

        let rect11 = CGRect(x: spot11.x, y: spot11.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect11)
        context.fillEllipse(in: rect11)

        let rect12 = CGRect(x: spot12.x, y: spot12.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect12)
        context.fillEllipse(in: rect12)

        let rect13 = CGRect(x: spot13.x, y: spot13.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect13)
        context.fillEllipse(in: rect13)

        let rect14 = CGRect(x: spot14.x, y: spot14.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect14)
        context.fillEllipse(in: rect14)

        let rect15 = CGRect(x: spot15.x, y: spot15.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect15)
        context.fillEllipse(in: rect15)

        let rect16 = CGRect(x: spot16.x, y: spot16.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect16)
        context.fillEllipse(in: rect16)
        
        let rect17 = CGRect(x: spot17.x, y: spot17.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect17)
        context.fillEllipse(in: rect17)
        
        let rect18 = CGRect(x: spot18.x, y: spot18.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect18)
        context.fillEllipse(in: rect18)
        
        let rect19 = CGRect(x: spot19.x, y: spot19.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect19)
        context.fillEllipse(in: rect19)
        
        let rect20 = CGRect(x: spot20.x, y: spot20.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect20)
        context.fillEllipse(in: rect20)
        
        let rect21 = CGRect(x: spot21.x, y: spot21.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect21)
        context.fillEllipse(in: rect21)
        
        let rect22 = CGRect(x: spot22.x, y: spot22.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect22)
        context.fillEllipse(in: rect22)
        
        let rect23 = CGRect(x: spot23.x, y: spot23.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect23)
        context.fillEllipse(in: rect23)
        
        let rect24 = CGRect(x: spot24.x, y: spot24.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect24)
        context.fillEllipse(in: rect24)
        
        let rect25 = CGRect(x: spot25.x, y: spot25.y, width: eclipseWidth, height: eclipseHeight)
        context.addEllipse(in: rect25)
        context.fillEllipse(in: rect25)
    }
}

class SlicesView: UIView {
    
    var slicesToShow = Int()
    let colorTheme = UIColor.black

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
        
        context.setLineWidth(3)
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
