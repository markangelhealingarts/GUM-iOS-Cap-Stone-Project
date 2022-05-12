//
//  AppDelegate.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/16/22.
//

import UIKit
import Firebase
<<<<<<< HEAD
import FirebaseCore
import UserNotifications
=======
>>>>>>> origin/sophia

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
<<<<<<< HEAD
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if(granted){
                print("User gave permissions")
            } else {
                print("Error: \(String(describing: error))")
            }
        }
=======
>>>>>>> origin/sophia
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
<<<<<<< HEAD
=======

>>>>>>> origin/sophia
        
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

