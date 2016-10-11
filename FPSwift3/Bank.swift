//
//  Optionals.swift
//  FPSwift3
//
//  Created by Dario on 10/7/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import UIKit

struct Account {
    let id : Int
    let balance : Int
    
    func toKeyPair() -> (Int,Account) {
        return (self.id, self)
    }
    
}


class Bank {
    
    private(set) var accounts : [Int : Account] //mutable state
    
    init() {
        accounts = [123 : Account(id:123, balance:30),12 : Account(id:12,balance:45)]
    }
    
    func withdraw0(accountNumber : Int, ammount : Int) -> Account? {
        if let account = accounts[accountNumber] {
            if account.balance >= ammount {
                let newAccount = Account(id: account.balance, balance: account.balance - ammount)
                accounts[newAccount.id] = newAccount //side effect
                return newAccount
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func withdraw1(accountNumber : Int, ammount : Int) -> Account? {
        let account : Account? = accounts[accountNumber]
        let accountWithEnoughBalance : Account? = account.filter {a in return a.balance >= ammount}
        let newAccount : Account? = accountWithEnoughBalance.flatMap { a in
            return Account(id:a.id, balance:a.balance - ammount)
        }
        newAccount.map {a in accounts[a.id] = a} //side effect
        return newAccount
    }
    
    func withdraw2(accountNumber : Int, ammount : Int) -> Account? {
        let accountWithEnoughBalance : Account? = accounts[accountNumber].filter {return $0.balance >= ammount}
        let newAccount : Account? = accountWithEnoughBalance.flatMap { a in
            return Account(id:a.id, balance:a.balance - ammount)
        }
        newAccount.map {a in accounts[a.id] = a} //side effect
        return newAccount
    }
    
    func withdraw3(accountNumber : Int, ammount : Int) -> Account? {
        let accountWithEnoughBalance: Account? = accounts[accountNumber].filter {return $0.balance >= ammount}
        let newAccount : Account? = accountWithEnoughBalance.flatMap {
            return Account(id:$0.id, balance:$0.balance - ammount)}
        newAccount.map {accounts[$0.id] = $0} //side effect
        return newAccount
    }
    
    func withdraw4(accountNumber : Int, ammount : Int) -> Account? {
        let newAccount: Account? = accounts[accountNumber].filter {return $0.balance >= ammount}
                                                          .flatMap {return Account(id:$0.id, balance:$0.balance - ammount)}        
        newAccount.map {accounts[$0.id] = $0} //side effect
        return newAccount
    }
    
    
}
