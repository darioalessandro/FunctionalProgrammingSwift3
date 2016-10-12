//
//  FunctionalVsOO.swift
//  FPSwift3
//
//  Created by Dario on 10/12/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import Foundation

class CalculatorOO {
    var a : Int = 0
    var b : Int = 0
    
    func add() -> Int {
        return a + b
    }
}

class CalculatorFunctional {
    
    func add(a : Int, b : Int) -> Int {
        return a + b
    }

    func op(a : Int, b : Int, f : (Int,Int) -> Int) -> Int {
        return f(a,b)
    }

    func op<A>(a : A, b:A, f:(A,A) -> A) -> A {
        return f(a,b)
    }
}


