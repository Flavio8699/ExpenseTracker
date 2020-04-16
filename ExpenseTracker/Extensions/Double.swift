//
//  Double.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import Foundation

extension Double {
    
    func format(f: String = ".2") -> String {
        return String(format: "%\(f)f", self).replacingOccurrences(of: ".", with: ",")
    }
    
}
