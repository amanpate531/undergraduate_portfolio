//
//  AppDelegate.swift
//  SplitMiniReminders
//
//  Created by Patel, Aman N on 3/15/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    let myRemindersData: MiniRemindersDataModel = MiniRemindersDataModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let myFile = docsurl.appendingPathComponent("items.plist")
            let fileData = try Data(contentsOf: myFile)
            let myReminders = try PropertyListDecoder().decode([Item].self, from: fileData)
            let lappDelegate = UIApplication.shared.delegate as! AppDelegate
            let lDataModel = lappDelegate.myRemindersData
            for item in myReminders {
                lDataModel.addEvent(content: item.theContent, category: item.theCategory, dueDate: item.theDate, done: item.theDoneFlag)
            }
            
        } catch {
            print(error)
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


}

