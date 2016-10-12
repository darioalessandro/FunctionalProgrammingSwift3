//
//  Optional + filter.swift
//  FPSwift3
//
//  Created by Dario on 10/11/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import Foundation



extension Optional {
    
    /// Evaluates the given closure when this `Optional` instance is not `nil`,
    /// passing the unwrapped value as a parameter.
    ///
    /// Use the `filter` method with a closure that returns an optional value.
    /// This example performs an arithmetic operation with an optional result on
    /// an optional integer.    
    ///
    /// - Parameter f: A closure that takes the unwrapped value
    ///   of the instance.
    /// - Returns: The result of the given closure. If this instance is `nil`,
    ///   returns `nil`.
    
    func filter(f : (Wrapped) throws -> Bool) rethrows -> Optional<Wrapped> {
        return try self.flatMap {
            if try f($0) { return self}
            else {return nil}
        }
    }
}
