//
//  AppDelegate.swift
//  Stock
//
//  Created by Scott moon on 04/12/2017.
//  Copyright © 2017 Scott moon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {

    var window: UIWindow?

}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: GroupsViewController())
        
        window?.makeKeyAndVisible()
        return true
    }
}

