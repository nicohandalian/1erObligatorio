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
        formatter.locale = Locale(identifier: "es_UY")
        return formatter.string(from: self)
    }
    
    func hourToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "es_UY")
        return formatter.string(from: self)
    }
    
}
