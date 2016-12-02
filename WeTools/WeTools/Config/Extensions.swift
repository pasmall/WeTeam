//
//  Extensions.swift
//  WeTools
//
//  Created by lhtb on 16/11/2.
//  Copyright © 2016年 lhtb. All rights reserved.
//

import Foundation
import UIKit



///    UI 扩展

extension UIView{
    
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
    
    var centerX: CGFloat {
        return self.center.x
    }
    
    var centerY: CGFloat {
        return self.center.y
    }
    
    
    
    func setX(x: CGFloat) {
        var frame = self.frame;
        frame.origin.x = x;
        self.frame = frame;
    }
    
    func setY(y: CGFloat) {
        var frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
    }
    
    func setWidth(w: CGFloat) {
        var frame = self.frame;
        frame.size.width = w;
        self.frame = frame;
    }
    
    func setHeight(h: CGFloat) {
        var frame = self.frame;
        frame.size.height = h;
        self.frame = frame;
    }
    func setCenterX(cx: CGFloat) {
        var center = self.center;
        center.x = cx;
        self.center = center;
    }
    
    func setCenterY(cy: CGFloat) {
        var center = self.center;
        center.y = cy;
        self.center = center;
    }
    
    
    
}


extension UIFont {
    class func HiraKakuProNW6(size: CGFloat) -> UIFont{
        return UIFont(name: "HiraKakuProN-W6", size: size)!
    }
    
    class func HiraKakuProNW3(size: CGFloat) -> UIFont{
        return UIFont(name: "HiraKakuProN-W3", size: size)!
    }
    
    class func Helvetica(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func HelveticaBold(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func HelveticaMedium(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func HelventicaNeue(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
}


extension UIColor {
    
    class func getColor(r:CGFloat,g:CGFloat,b:CGFloat,l:CGFloat = 1) ->UIColor{
        
        let color = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        
        return color
        
    }

}



/// Foundation 扩展


public extension Int {
    
    private func newEmptyDateComponents() -> NSDateComponents! {
        let dateComponents = NSDateComponents()
        dateComponents.year = 0
        dateComponents.month = 0
        dateComponents.day = 0
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        return dateComponents
    }
    
    var year: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.year = self
        return components!
    }
    
    var month: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.month = self
        return components!
    }
    
    var day: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.day = self
        return components!
    }
    
    var hour: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.hour = self
        return components!
    }
    
    var minute: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.minute = self
        return components!
    }
    
    var second: NSDateComponents {
        let components = self.newEmptyDateComponents()
        components?.second = self
        return components!
    }
}


public extension NSDate {
    
    private convenience init(date otherDate: NSDate) {
        let timeInterval = otherDate.timeIntervalSince1970
        self.init(timeIntervalSince1970: timeInterval)
    }
    
    convenience init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        let date = calendar!.date(from: components as DateComponents)
        self.init(date: date! as NSDate)
    }
    
}


func + (left: NSDate, right: NSDateComponents) -> NSDate {
    let calendar = NSCalendar.current
    var components = calendar.dateComponents([.year , .month ,.day , .hour , .minute , .second] , from: left as Date)
    components.year = components.year! + right.year
    components.month = components.month! + right.month
    components.day = components.day! + right.day
    components.hour = components.hour! + right.hour
    components.minute = components.minute! + right.minute
    components.second = components.second! + right.second
    return calendar.date(from: components)! as NSDate
}


func - (left: NSDate, right: NSDateComponents) -> NSDate {
    let calendar = NSCalendar.current
    var components = calendar.dateComponents([.year , .month ,.day , .hour , .minute , .second] , from: left as Date)
    components.year =  components.year! - right.year
    components.month =  components.month! - right.month
    components.day = components.day! - right.day
    components.hour = components.hour! - right.hour
    components.minute = components.minute! - right.minute
    components.second = components.second! - right.second
    return calendar.date(from: components)! as NSDate
}


func > (left: NSDate, right: NSDate) -> Bool {
    let timeInterval = left.timeIntervalSince(right as Date)
    return timeInterval > 0
}


func < (left: NSDate, right: NSDate) -> Bool {
    let timeInterval = left.timeIntervalSince(right as Date)
    return timeInterval < 0
}


func >= (left: NSDate, right: NSDate) -> Bool {
    return (left > right) || (left == right)
}


func <= (left: NSDate, right: NSDate) -> Bool {
    return (left < right) || (left == right)
}













