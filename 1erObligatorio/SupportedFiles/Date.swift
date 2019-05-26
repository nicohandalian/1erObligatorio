//
//  Date.swift
//  1erObligatorio
//
//  Created by Nicolás Handalian on 5/26/19.
//  Copyright © 2019 Nicolás Handalian. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter.string(from: self)
    }
    
}
