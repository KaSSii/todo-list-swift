//
//  AppDelegate.swift
//  Todo list
//
//  Created by Jack on 19/6/20.
//  Copyright © 2020 Jack. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(
            schemaVersion: 4,
            migrationBlock: { migration, oldSchemaVersion in
                if(oldSchemaVersion < 1) {
                }
                if(oldSchemaVersion < 2) {
                    
                }
                if(oldSchemaVersion < 3) {
                    
                }
                if(oldSchemaVersion < 4) {
                    
                }
        })
        
        Realm.Configuration.defaultConfiguration = config;
        
        let realm = try! Realm();
        
        let items = realm.objects(ItemGroup.self);
        
        let itemsArray = Array(items);
        
        store.dispatch(initialLoad(groups: itemsArray));
        
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

