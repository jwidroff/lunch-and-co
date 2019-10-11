//
//  TimerLabel.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/11/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

class TimerLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "00:00"
        textColor = .white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 50.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
