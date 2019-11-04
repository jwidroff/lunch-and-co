//
//  TimerLabel.swift
//  Lunch And Co
//
//  Created by Jeffery Widroff on 10/11/19.
//  Copyright © 2019 Jeffery Widroff. All rights reserved.
//

import UIKit

protocol UpdateDelegate {
    
  func updateDatabase()
    
}

class TimerLabel: UILabel {

    var day = Int()
    var hour = Int()
    var tomorrowsMonth = Int()
    var tomorrowsDay = Int()
    var tomorrowsYear = Int()
    var timer = Timer()
    var delegate: UpdateDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 50.0)
//        font = UIFont(name: "System", size: 50.0)

        
        let now = Date(timeIntervalSinceNow: 0.0)
        day = Calendar.current.component(.weekday, from: now)
        hour = Calendar.current.component(.hour, from: now)
        
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
        let tomorrowsComponents = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: tomorrow as Date)
        tomorrowsDay = tomorrowsComponents.day!
        tomorrowsMonth = tomorrowsComponents.month!
        tomorrowsYear = tomorrowsComponents.year!
        check4Tomorrow()
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
    
    func check4Tomorrow() {
        
        numberOfLines = 2
        
//        font = UIFont(name: "System", size: 30.0)
        
        switch day {
            
        case 1: //sunday
            text = "Check back on Monday \(tomorrowsMonth)-\(tomorrowsDay)-\(tomorrowsYear)"
            font = UIFont.systemFont(ofSize: 30.0)
        case 2: //monday
            
            if hour > 0 && hour < 12 {
//                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: true)
                
                runTimer()
                
                
            } else {
                text = "Check back on Tuesday \(tomorrowsMonth)-\(tomorrowsDay)-\(tomorrowsYear)"
                font = UIFont.systemFont(ofSize: 30.0)
            }
            
        case 3: //tuesday
            if hour > 0 && hour < 12 {
//                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: true)
                
                runTimer()
                
            } else {
                text = "Check back on Wednesday \(tomorrowsMonth)-\(tomorrowsDay)-\(tomorrowsYear)"
                font = UIFont.systemFont(ofSize: 30.0)
            }
            
        case 4: //wednesday
            
            if hour > 0 && hour < 12 {
//                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: true)
                

                runTimer()
                
            } else {
                text = "Check back on Thursday \(tomorrowsMonth)-\(tomorrowsDay)-\(tomorrowsYear)"
                font = UIFont.systemFont(ofSize: 30.0)
            }
            
        case 5: //thursday
            if hour > 0 && hour < 12 {
//                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: true)
                
                runTimer()
                
            } else {
                text = "Check back on Friday \(tomorrowsMonth)-\(tomorrowsDay)-\(tomorrowsYear)"
                font = UIFont.systemFont(ofSize: 30.0)
            }
            
        case 6: //friday
            if hour > 0 && hour < 12 { //MARK: Change back
//                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: true)
                
                runTimer()
                
            } else {
                text = "Check back on Monday \(tomorrowsMonth)-\(tomorrowsDay + 2)-\(tomorrowsYear)"
                font = UIFont.systemFont(ofSize: 30.0)
            }
            
        case 7: //saturday
            text = "Check back on Monday \(tomorrowsMonth)-\(tomorrowsDay + 1)-\(tomorrowsYear)"
            font = UIFont.systemFont(ofSize: 30.0)

        default:
            break
            
        }
    }
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCalc), userInfo: nil, repeats: false)

    }

    @objc func timerCalc() {
        
        let date = NSDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date as Date)
        let currentDate = calendar.date(from: components)
        let userCalendar = Calendar.current
        
        
        // here we set the due date. When the timer is supposed to finish
        let competitionDate = NSDateComponents()
        competitionDate.year = components.year!
        competitionDate.month = components.month!
        competitionDate.day = components.day!
        
        //MARK: Change back
        competitionDate.hour = 12
        competitionDate.minute = 00
        competitionDate.second = 00
        
        let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
        
        //here we change the seconds to hours,minutes and days
        let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: competitionDay)
        
        if CompetitionDayDifference.hour! == 0 && CompetitionDayDifference.minute! == 0 && CompetitionDayDifference.second! == 0 {
            
            delegate?.updateDatabase()
            timer.invalidate()
            return
            
        } else {
            
            check4Tomorrow()
            
        }
        
        //finally, here we set the variable to our remaining time
        var daysLeft:String {
            get {
                if "\(CompetitionDayDifference.day!)".count > 1 {
                    return "\(CompetitionDayDifference.day!)"
                } else {
                    return "0\(CompetitionDayDifference.day!)"
                }
            }
        }
        var hoursLeft:String {
            get {
                if "\(CompetitionDayDifference.hour!)".count > 1 {
                    return "\(CompetitionDayDifference.hour!)"
                } else {
                    return "0\(CompetitionDayDifference.hour!)"
                }
            }
        }
        var minutesLeft:String {
            get {
                if "\(CompetitionDayDifference.minute!)".count > 1 {
                    return "\(CompetitionDayDifference.minute!)"
                } else {
                    return "0\(CompetitionDayDifference.minute!)"
                }
            }
        }
        var secondsLeft:String {
            get {
                if "\(CompetitionDayDifference.second!)".count > 1 {
                    return "\(CompetitionDayDifference.second!)"
                } else {
                    return "0\(CompetitionDayDifference.second!)"
                }
            }
        }
        text = "\(hoursLeft):\(minutesLeft):\(secondsLeft)"
    }
}
