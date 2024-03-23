//
//  AppDelegate.swift
//  PRAKTIKA BAZA D
//
//  Created by BK on 18.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: RealmVc())
        window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

}
