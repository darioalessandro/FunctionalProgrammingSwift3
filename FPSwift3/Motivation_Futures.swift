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
    let hasStent : Bool
    
    public func openTorax() -> Patient {
        switch toraxState {
        case .open:
            return self
        case .closed:
            return Patient(name: name, gender: gender, age: age, toraxState: .open, hasStent: hasStent)
        }
    }
    
    public func closeTorax() -> Patient {
        switch toraxState {
        case .closed:
            return self
        case .open:
            return Patient(name: name, gender: gender, age: age, toraxState: .closed, hasStent: hasStent)
        }
    }
    
    public func setHasStent(hasStent : Bool) -> Patient {
        return Patient(name: name, gender: gender, age: age, toraxState: toraxState, hasStent: hasStent)
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
    
    public func performHeartSurgery2() throws -> Patient {
        try openTorax()
        try insertCoronaryStent()
        try closeTorax()
        return self.patient!
    }
    
    private func openTorax() throws {}
    
    private func insertCoronaryStent() throws {}
    
    private func closeTorax() throws {}

}

public class LameSyncDoctor2 {

    public var patient : Patient?

    public func performHeartSurgery() -> Bool {
        return openTorax() && insertCoronaryStent() && closeTorax()
    }

    private func openTorax() -> Bool { return true }

    private func insertCoronaryStent() -> Bool { return true }

    private func closeTorax() -> Bool  { return true }

}

public class LameAsyncDoctor {
    
    public typealias OnResult = (_ p : Patient, _ e : NSError?) -> ()
    
    var patient : Patient?
    
    public func performHeartSurgery(onResult : @escaping OnResult) -> Void {
        openTorax { (p1, surgeryError) in
            if let _ = surgeryError {
                onResult(p1,surgeryError)
            } else {
                self.insertCoronaryStent { (p2, coronaryStentError) in
                    if let _ = coronaryStentError {
                        onResult(p2,coronaryStentError)
                    } else {
                        self.closeTorax { (p3, closeToraxError) in
                            onResult(p3,closeToraxError)
                        }
                    }
                }
            }
        }
    }
    
    private func openTorax(onResult : @escaping OnResult) -> Void {
        queue.async {
            Thread.sleep(forTimeInterval: 2)
            onResult(self.patient!.openTorax(),nil)
        }
    }
    
    private func insertCoronaryStent(onResult : @escaping OnResult) -> Void {
        queue.async {
            Thread.sleep(forTimeInterval: 2)
            onResult(self.patient!.setHasStent(hasStent: true),NSError(domain: "some error", code: 0, userInfo: nil))
        }
    }
    
    private func closeTorax(onResult : @escaping OnResult) -> Void {
        queue.async {
            Thread.sleep(forTimeInterval: 2)
            onResult(self.patient!.closeTorax(),nil)
        }
    }
    
    private let queue : DispatchQueue = DispatchQueue.init(label: "LameAsyncDoctor")
    
}


public class FunctionalAsyncDoctor {
    
    private let queue : DispatchQueue = DispatchQueue.init(label: "FunctionalAsyncDoctor")
    
    public func performHeartSurgery(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return self.openTorax(p : p).flatMap {
               self.insertCoronaryStent(p: $0)}.flatMap {
               self.closeTorax(p: $0)}
    }
    
    private func openTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                complete(.success(p.openTorax()))
            }
        }
    }
    
    private func insertCoronaryStent(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                complete(.success(p.setHasStent(hasStent: true)))
//                complete(.failure(HeartSurgeryError.heartAttackWhileInsertingStent))
            }
        }
    }
    
    private func closeTorax(p : Patient) -> Future<Patient,HeartSurgeryError> {
        return Future { complete in
            queue.async {
                Thread.sleep(forTimeInterval: 2)
                complete(.success(p.closeTorax()))
            }
        }
    }
}

