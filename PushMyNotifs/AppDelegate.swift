//
//  AppDelegate.swift
//  PushMyNotifs
//
//  Created by iulian david on 11/25/16.
//  Copyright © 2016 iulian david. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        if #available(iOS 8.0, *) {
            let settings :UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            let types: UIRemoteNotificationType = [.alert, .badge, .sound]
            application.registerForRemoteNotifications(matching: types)
        }
        
        //add Firebase config
        FIRApp.configure()
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.firInstanceIDTokenRefresh, object: nil)
        return true
        
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        
        //clean up code
        FIRMessaging.messaging().disconnect()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        connecToFcm()
    }

   

    func tokenRefreshNotification(notification: NSNotification) throws {
        guard let refreshedToken = FIRInstanceID.instanceID().token() else {
            fatalError()
        }
        print("InstanceID token: \(refreshedToken)")
        connecToFcm()
        
    }
    
    /**
     In order to work with Firebase we need to connect to
     FirebaseCentralMessaging
    */
    func connecToFcm(){
        FIRMessaging.messaging().connect(completion: {
            error in
            if (error != nil) {
                print("Unable to connect to Firebase \(error.debugDescription)")
            } else {
                print("connected to FCM")
            }
        })
    }
    
    
}

