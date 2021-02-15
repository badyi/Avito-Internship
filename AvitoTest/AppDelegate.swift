//
//  AppDelegate.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 16.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = .white
        navigationController.viewControllers = [AdvertViewController()]
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        return true
    }

}

