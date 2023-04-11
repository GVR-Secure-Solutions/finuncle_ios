//
//  Constant.swift
//  Finuncle
//
//  Created by Rahul on 02/04/23.
//

import Foundation

//MARK: Globals Variable



struct K {
    
    static var tags = Tags()
    static let baseURL = "https://api.finuncle.com/api/"
    
    struct API {
        static let expenses = baseURL + "expenses/"
        static let tag = baseURL + "tag/"
    }
    
}
