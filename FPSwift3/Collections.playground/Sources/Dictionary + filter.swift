//
//  Dictionary + filter.swift
//  FPSwift3
//
//  Created by Dario on 10/11/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public func filterCopy(_ isIncluded: (Key, Value) throws -> Bool) rethrows -> [Key : Value] {
        var newDict = [Key : Value]()
        try self.forEach {if try isIncluded($0,$1) {newDict[$0] = $1}}
        return newDict
    }
    
    public mutating func filterInPlace(_ isIncluded: (Key, Value) throws -> Bool) rethrows -> [Key : Value] {
        try self.forEach { (key: Key, value: Value) in
            if try !isIncluded(key,value) {self.removeValue(forKey: key)}
        }        
        return self
    }
}
