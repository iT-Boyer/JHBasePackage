//
//  JHBaseDateExt.swift
//  
//
//  Created by pk on 2021/8/27.
//

import Foundation

@objc extension NSDate{
    
    public static func timestampSince1970() -> String {
        let datenow = NSDate()
        //现在时间
        let interval = datenow.timeIntervalSince1970*1000
        let timeSp = String(format: "%.0f", interval)
        return timeSp
    }
    
    public static func changeTimeStampToString(timeStamp:String) -> String {
        var fStr = "yyyy-MM-dd HH:mm:ss"
        if timeStamp.contains(".") {
            fStr = "yyyy.MM.dd HH:mm:ss"
        } else if timeStamp.contains("年") {
            fStr = "yyyy年MM月dd日 HH:mm:ss"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = fStr
        let dateCurrentStr = formatter.date(from: timeStamp)
        if (dateCurrentStr == nil) {
            //格式不对是显示当前时间
            return "\(CLong(NSDate().timeIntervalSince1970))"
        }
        let timeSp = "\(CLong(dateCurrentStr!.timeIntervalSince1970))"
        return timeSp
    }
    
}
