//
//  AppDelegate.swift
//  Venues
//
//  Created by Camilo Rodriguez Gaviria on 17/04/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if #available(iOS 13, *) {
            // do only pure app launch stuff, not interface stuff
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let venuesViewController = VenuesViewController()
            let navigationViewController = NavigationController(rootViewController: venuesViewController)
            window.rootViewController = navigationViewController
            window.makeKeyAndVisible()
        }
        return true
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = SceneDelegate.self
        return sceneConfiguration
    }
}
