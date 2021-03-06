//
//  AppDelegate.swift
//  FPSwift3
//
//  Created by Dario Lencina on 10/6/16.
//  Copyright © 2016 BlackFireApps. All rights reserved.
//

import UIKit
import BrightFutures

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let p = Patient(name: "George Carlin", gender: .masculine, age: 70, toraxState: .closed, hasStent: false)
        let f = FunctionalAsyncDoctor().performHeartSurgery(p: p)
        f.map { p in
            print("patient is ready \(p)")
        }.onFailure { (error) in
            print("error \(error)")
        }

        let lameAsyncDoctor = LameAsyncDoctor()
        lameAsyncDoctor.patient = p
        lameAsyncDoctor.performHeartSurgery { (patient, error) in
            if let e = error {
                print("error : \(e)")
            } else {
                print("success \(patient)")
            }
        }
        
        let s : Int? = 4
        
        print("s = \(s.filter {$0 > 3})")
        
        let customFilter = [123:"first",124 : "lasto"].filterCopy {(key,value) in value == "lasto"}
        print(customFilter)

        let customFilter2 = [123:"first",124 : "lasto"].filterCopy {$1 == "lasto"}
        print(customFilter2)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }


}

