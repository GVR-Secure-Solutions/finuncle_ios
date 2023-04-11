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
}
