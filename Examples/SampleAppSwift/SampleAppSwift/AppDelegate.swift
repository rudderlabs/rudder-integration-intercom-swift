//
//  AppDelegate.swift
//  ExampleSwift
//
//  Created by Arnab Pal on 09/05/20.
//  Copyright © 2020 RudderStack. All rights reserved.
//

import UIKit
import Rudder
import RudderIntercom

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var client: RSClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config: RSConfig = RSConfig(writeKey: "<WRITE_KEY>")
            .dataPlaneURL("<DATA_PLANE_URL>")
            .loglevel(.debug)
            .trackLifecycleEvents(true)
            .recordScreenViews(true)
        
        RSClient.sharedInstance().configure(with: config)
        RSClient.sharedInstance().addDestination(RudderIntercomDestination())
        RSClient.sharedInstance().track("Track 1")
        RSClient.sharedInstance().track("test_user_id_2")
        RSClient.sharedInstance().track("daily_rewards_claim")
        RSClient.sharedInstance().track("level_up")
        RSClient.sharedInstance().track("revenue")
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension UIApplicationDelegate {
    var client: RSClient? {
        if let appDelegate = self as? AppDelegate {
            return appDelegate.client
        }
        return nil
    }
}
