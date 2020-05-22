//
//  AppDelegate.swift
//  Lotto365
//
//  Created by Song on 18/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["98dcf8cc42150a49a4328e8870307e3e"]
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        application.registerForRemoteNotifications()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }


}

//MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("🔸[FCM] deviceToken :", fcmToken)
    }
}

//MARK: - Remote Notification
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("🔸apns : \(deviceToken.reduce("", {$0 + String(format: "%02X", $1)}))")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        print("🔸did receive remote notification : \(userInfo)")
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("🔸did fail to register for remote notification with error : \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        print("🔸did receive remote notification (fetch completion): \(userInfo)")
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

//MARK: - UNUserNotificationCenterDelgate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
//        let notification = response.notification
//        guard let userInfo = notification.request.content.userInfo as? [String: Any] else { return }
        
        if response.actionIdentifier == UNNotificationDismissActionIdentifier {
            print ("Message Closed")
        }
        else if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            print ("푸시 메시지 클릭 했을 때")
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
//        self.showRootViewController(UIViewController())
    }
}
