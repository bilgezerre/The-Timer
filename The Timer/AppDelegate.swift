//
//  AppDelegate.swift
//  The Timer
//
//  Created by Bilge Zerre on 22.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let view = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                guard let window = appDelegate.window else {
                    return true
                }

                window.rootViewController = UINavigationController(rootViewController: view)
                window.makeKeyAndVisible()
        
        return true
    }

}

