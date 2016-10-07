//
//  Motivation.swift
//  FPSwift3
//
//  Created by Dario Lencina on 10/6/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import UIKit
import BrightFutures

public enum Gender {
    case masculine
    case femenine
}

public enum OrganState {
    case open
    case closed
}

public enum HeartSurgeryError : Error {
    case heartAttackWhileOpeningTorax
    case heartAttackWhileInsertingStent
    case heartAttackClosingTorax
}

public struct Patient {
    
    let name : String
    let gender : Gender
    let age : UInt
    let toraxState : OrganState
    
    public func openTorax() -> Patient {
        switch toraxState {
        case .open:
            return self
        case .closed:
            return Patient(name: name, gender: gender, age: age, toraxState: .open)
        }
    }
    
    public func closeTorax() -> Patient {
        switch toraxState {
        case .closed:
            return self
        case .open:
            return Patient(name: name, gender: gender, age: age, toraxState: .closed)
        }
    }
}

public class LameSyncDoctor {
    
    public var patient : Patient?
    
    public func performHeartSurgery() -> Bool {
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
    
    internal func openTorax() throws {}
    
    internal func insertCoronaryStent() throws {}
    
    internal func closeTorax() throws {}

}

public class LameAsyncDoctor {
    
    public typealias OnResult = (_ p : Patient, _ e : NSError?) -> ()
    
    var patient : Patient?
    
    public func performHeartSurgery(onResult : OnResult) -> Void {
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
    
    internal func openTorax(onResult : OnResult) -> Void {}
    
    internal func insertCoronaryStent(onResult : OnResult) -> Void {}
    
    func closeTorax(onResult : OnResult) -> Void {}
    
}


public class FunctionalAsyncDoctor {
    
    let queue : DispatchQueue = DispatchQueue.init(label: "doctorQueue")
    
    public func performHeartSurgery(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return self.openTorax(p : p).flatMap {
               self.insertCoronaryStent(p: $0)}.flatMap {
               self.closeTorax(p: $0)}
    }
    
    internal func openTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                complete(.success(p))
            }
        }
    }
    
    internal func insertCoronaryStent(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                //complete(.success(p))
                complete(.failure(HeartSurgeryError.heartAttackWhileInsertingStent))
            }
        }
    }
    
    internal func closeTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                complete(.success(p))
            }
        }
    }
}

