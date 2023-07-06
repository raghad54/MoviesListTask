//
//  AppDelegateExtension.swift
//  Etihad-Member
//
//  Created by mohamed abdo on 3/20/19.
//  Copyright © 2019 Onnety. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import UserNotifications

// MARK: - ...  Push Notification Helper & sound Handler
typealias SoundHandler = (Bool) -> Void
private let gcmMessageIDKey = "gcm.message_id"
// MARK: - ...  Notification Control functions
extension AppDelegate: FirebaseNotificationDelegate {
    // MARK: - ...  Did click on notification
    func notificationControl(notification: [AnyHashable: Any]) {
    }
    // MARK: - ...  Did present the notification
    func notificationControlWillPresent(notification: [AnyHashable: Any], closure: SoundHandler? = nil) {
        closure?(true)
    }
}

extension AppDelegate {
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        print("hiITEM")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")

        //        Messaging.messaging().subscribe(toTopic: "/topics/mp_client_ios")
        Messaging.messaging()
            .setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        Messaging.messaging()
            .setAPNSToken(deviceToken, type: MessagingAPNSTokenType.prod)
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
}

//device token delegates
extension AppDelegate: MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        UD.DEVICE_TOKEN = fcmToken
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {

    // The method will be called on the delegate only if the application is in the foreground.
    //If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented.
    //The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list.
    //This decision should be based on whether the information in the notification is otherwise visible to the user.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID  = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        //print("here it  is\(userInfo)")

        notificationControlWillPresent(notification: userInfo) { sound in
            if sound {
                completionHandler([.alert, .badge, .sound])
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        let userInfo = response.notification.request.content.userInfo
        print(userInfo)

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        notificationControl(notification: userInfo)
        completionHandler()
    }
}
