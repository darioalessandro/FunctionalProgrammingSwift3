//
//  Optional + filter.swift
//  FPSwift3
//
//  Created by Dario on 10/11/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import Foundation

extension Optional {
    func filter(f : (Wrapped) throws -> Bool) rethrows -> Optional<Wrapped> {
        return try self.flatMap {
            if try f($0) { return self}
            else {return nil}
        }
    }
}
