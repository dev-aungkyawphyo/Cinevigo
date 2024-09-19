//
//  AppDelegate.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// InitialViewController
        let initialViewController = LoginScreenViewController.instantiate(storyboard: .login)
        let navigationController = CineNavigationController(rootViewController: initialViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }



}

