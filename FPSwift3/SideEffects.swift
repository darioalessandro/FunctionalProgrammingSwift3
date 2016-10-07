//
//  SideEffects.swift
//  FPSwift3
//
//  Created by Dario on 10/7/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import UIKit

class SideEffects {
    
    func add(a:Int, b:Int) -> Int {
        launchPolarisMissiles() //side effect
        solveWorldHunger() // side effect
        return a + b
    }
    
    func launchPolarisMissiles() -> Void {}
    
    func solveWorldHunger() -> Void {}
}
