//
//  String+Extension.swift
//  Finuncle
//
//  Created by Rahul on 02/04/23.
//

import Foundation
import UIKit

extension String {
    
    func convertDateString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "EEE d MMMM yyyy"
            let convertedDate = dateFormatter.string(from: date)
            return convertedDate
        } else {
            return nil
        }
    }
}


extension String{
  
    func getSize() -> CGFloat{
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
    
    func toDate() -> Date? {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
           formatter.timeZone = TimeZone.current
           guard let date = formatter.date(from: self) else {
               print("Error: Could not parse date string: \(self)")
               if let dateError = DateFormatter().date(from: self)?.debugDescription {
                   print("Debug info: \(dateError)")
               }
               return nil
           }
           return date
       }
}
