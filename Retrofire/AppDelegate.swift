//
//  AppDelegate.swift
//  Retrofire
//
//  Created by Theo Turner on 04/08/2017.
//  Copyright © 2018 Theo Turner. All rights reserved.
//

import GoogleMobileAds
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        return true
    }
    
}
