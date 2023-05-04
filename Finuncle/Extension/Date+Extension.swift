//
//  Date+Extension.swift
//  Finuncle
//
//  Created by Rahul on 26/04/23.
//

import Foundation

extension Date {
    func toString(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
   
    
}
