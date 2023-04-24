//
//  AppDelegate.swift
//  GUM-ios
//
//  Created by Tim Johnson on 2/16/22.
//

import UIKit
import Firebase
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate,  UNUserNotificationCenterDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if(granted){
                print("User gave permissions")
            } else {
                print("Error: \(String(describing: error))")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        print("Delegate set to \(String(describing: UNUserNotificationCenter.current().delegate))")
        
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
               // The app was opened via a notification
            UserDefaults.standard.set(true, forKey: "notifPressed")
            print("Launched with remote Notification: \(notification)")
            UserDefaults.standard.set("ViaRemoteNotif", forKey: "notifTest")
           } else {
               // The app was launched normally
               UserDefaults.standard.set(nil, forKey: "notifPressed")
               print("Launched normally")
               UserDefaults.standard.set("ViaNormal", forKey: "notifTest")
           }
        
        return true
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UserDefaults.standard.set(true, forKey: "notifPressed")
        UserDefaults.standard.set("ViaNotif", forKey: "notifTest")
        print("Launched via notification")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UserDefaults.standard.set(true, forKey: "notifPressed")
        UserDefaults.standard.set("ReopViaNotif", forKey: "notifTest")
        print("Reopened via notification")
        // Display a banner or alert to the user
        completionHandler([.sound, .badge])
    }




}
