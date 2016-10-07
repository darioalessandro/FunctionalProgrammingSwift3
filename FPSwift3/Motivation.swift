//
//  Motivation.swift
//  FPSwift3
//
//  Created by Dario Lencina on 10/6/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import UIKit
import BrightFutures

enum Gender {
    case masculine
    case femenine
}

enum OrganState {
    case open
    case closed
}

struct Patient {
    
    let name : String
    let gender : Gender
    let age : UInt
    let toraxState : OrganState
    
    func openTorax() -> Patient {
        switch toraxState {
        case .open:
            return self
        case .closed:
            return Patient(name: name, gender: gender, age: age, toraxState: .open)
        }
    }
    
    func closeTorax() -> Patient {
        switch toraxState {
        case .closed:
            return self
        case .open:
            return Patient(name: name, gender: gender, age: age, toraxState: .closed)
        }
    }
}

class LameSyncDoctor {
    
    var patient : Patient?
    
    func performHeartSurgery() -> Bool {
        do {
            try openTorax()
            try insertCoronaryStent()
            try closeTorax()
            return true
        } catch {
            print("something bad happened, who cares what")
            return false
        }
    }
    
    func openTorax() throws {}
    
    func insertCoronaryStent() throws {}
    
    func closeTorax() throws {}

}

class LameAsyncDoctor {
    
    typealias OnResult = (_ p : Patient, _ e : NSError?) -> ()
    
    var patient : Patient?
    
    func performHeartSurgery(onResult : OnResult) -> Void {
        openTorax { (p1, surgeryError) in
            if let _ = surgeryError {
                onResult(p1,surgeryError)
            } else {
                insertCoronaryStent { (p2, coronaryStentError) in
                    if let _ = coronaryStentError {
                        onResult(p2,surgeryError)
                    } else {
                        closeTorax { (p3, closeToraxError) in
                            onResult(p3,closeToraxError)
                        }
                    }
                }
            }
        }
    }
    
    func openTorax(onResult : OnResult) -> Void {}
    
    func insertCoronaryStent(onResult : OnResult) -> Void {}
    
    func closeTorax(onResult : OnResult) -> Void {}
    
}

enum HeartSurgeryError : Error {
    case heartAttackWhileOpeningTorax
    case heartAttackWhileInsertingStent
    case heartAttackClosingTorax
}

class FunctionalAsyncDoctor {
    
    func performHeartSurgery(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return self.openTorax(p : p).flatMap {
               self.insertCoronaryStent(p: $0)}.flatMap {
               self.closeTorax(p: $0)}
    }
    
    func openTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 2000)
                complete(.success(p))
            }
        }
    }
    
    func insertCoronaryStent(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 2000)
                complete(.success(p))
            }
        }
    }
    
    func closeTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 2000)
                complete(.success(p))
            }
        }
    }
}

