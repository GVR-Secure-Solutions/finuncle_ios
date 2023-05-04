//
//  Dictionary+Extension.swift
//  Finuncle
//
//  Created by Rahul on 26/04/23.
//

import Foundation

extension Dictionary {
    
    func toJson() -> String? {
          do {
              let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
              return String(data: jsonData, encoding: .utf8)
          } catch {
              print("Error serializing dictionary to JSON: \(error.localizedDescription)")
              return nil
          }
      }
    
}
