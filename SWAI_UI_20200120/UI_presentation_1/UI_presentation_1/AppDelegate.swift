//
//  AppDelegate.swift
//  UI_presentation_1
//
//  Created by 임연지 on 2020/01/15.
//  Copyright © 2020 임연지. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
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
            
            UIApplication.shared.applicationIconBadgeNumber = 0
        }

        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }


    }

    extension AppDelegate: UNUserNotificationCenterDelegate {
        
//       @IBAction func checkWakeUp(){
//            let alertController = UIAlertController(title: "Did you get up?", message: "Press OK to turn off alarm", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {UIAlertAction in print("OK")}))
//            alertController.present(alertController, animated:true, completion: nil)
//        }
        
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            completionHandler([.alert, .sound])
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    didReceive response: UNNotificationResponse,
                                    withCompletionHandler completionHandler: @escaping () -> Void) {
            
            if response.notification.request.identifier == "Local Notification" {
                print("Handling notifications with the Local Notification Identifier")
            }
            
            completionHandler()
        }
        //Normal Sleep Mode를 위한 Notification 함수
        func scheduleNotification(wakeUpTimeSec:Double) {
            
            let content = UNMutableNotificationContent() // Содержимое уведомления
            let categoryIdentifire = "Delete Notification Type"
            
            content.title = "Normal Sleep Mode"
            content.body = "Time to wkae up!"
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.categoryIdentifier = categoryIdentifire
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: wakeUpTimeSec, repeats: false)//푸시 알림 인터벌 여기서 조정
            let identifier = "Local Notification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
            
            let actionA = UNNotificationAction(identifier: "ActionA", title: "Action A", options: [])
            let actionB = UNNotificationAction(identifier: "ActionB", title: "Action B", options: [])
            let category = UNNotificationCategory(identifier: categoryIdentifire,
                                                  actions: [actionA, actionB],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
        }
        
        //I Don't Care Mode Notification
        func IDCNotification(ageAsString:String) {
            let ageAsInteger = Int(ageAsString) ?? 20
            let sleepCycle:Int = 5400
            var userSleepTime:Int
            let timeToGetSleep:Int = 60 * 20 //잠에 드는 시간
                if (ageAsInteger <= 3){
                    userSleepTime = (sleepCycle * 8 + timeToGetSleep)
                }
                else if ((ageAsInteger > 3) && (ageAsInteger <= 6)){
                    userSleepTime = (sleepCycle * 7 + timeToGetSleep)
                }
                else if ((ageAsInteger > 6)&&(ageAsInteger <= 14)){
                    userSleepTime = (sleepCycle * 6 + timeToGetSleep)
                }
                else if ((ageAsInteger > 14)&&(ageAsInteger <= 18)){
                    userSleepTime = (sleepCycle * 6 + timeToGetSleep)
                }
                else if ((ageAsInteger > 18)&&(ageAsInteger <= 26)){
                    userSleepTime = (sleepCycle * 6 + timeToGetSleep)
                }
                else if ((ageAsInteger > 26)&&(ageAsInteger <= 64)){
                    userSleepTime = (sleepCycle * 5 + timeToGetSleep)
                }
                else{
                    userSleepTime = (sleepCycle * 6 + timeToGetSleep)
                }
            print(userSleepTime)
            
            let content = UNMutableNotificationContent()
            let categoryIdentifire = "Delete Notification Type"
            
            content.title = "IDC Mode Alarm"
            content.body = "Time to wake up!"
            content.sound = UNNotificationSound.default
//            content.badge = 1
            content.categoryIdentifier = categoryIdentifire
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(userSleepTime), repeats: false)//푸시 알림 인터벌 여기서 조정
            let identifier = "Local Notification"
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Error \(error.localizedDescription)")
                }
            }
            
            let actionA = UNNotificationAction(identifier: "ActionA", title: "Action A", options: [])
            let actionB = UNNotificationAction(identifier: "ActionB", title: "Action B", options: [])
            let category = UNNotificationCategory(identifier: categoryIdentifire,
                                                  actions: [actionA, actionB],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            notificationCenter.setNotificationCategories([category])
        }
}

