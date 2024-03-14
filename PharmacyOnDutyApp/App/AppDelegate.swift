//
//  AppDelegate.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 6.03.2024.
//

import UIKit
import GoogleMobileAds
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = UIColor.nav
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.nav]
        navigationBarAppearace.tintColor = .nav
        
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "72fe5fd0a9242a42eb628d20db3e80d4" ]
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
       
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

