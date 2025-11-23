//
//  SceneDelegate.swift
//  TransitionDemo
//
//  Created by Timur Saidov on 24.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var tabBarIcons: [UIImage] = [
        UIImage(named: "accounts")!,
        UIImage(named: "settings")!,
        UIImage(systemName: "rectangle.portrait.and.arrow.right")!
    ]


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let tabBarController = UITabBarController()
        let accounts = AccountsViewController()
        accounts.title = "Accounts"
        let accountsNav = UINavigationController(rootViewController: accounts)

        let settings = SettingsViewController()
        settings.title = "Demo"
        let settingsNav = UINavigationController(rootViewController: settings)
        
        settingsNav.navigationBar.prefersLargeTitles = true

        tabBarController.viewControllers = [
            accountsNav,
            settingsNav
        ]
        
        tabBarController.tabBar.tintColor = .blue
        tabBarController.viewControllers?.enumerated().forEach {
            if $0 == 0 {
                $1.tabBarItem.image = tabBarIcons[$0]
                $1.tabBarItem.title = "Accounts"
            } else if $0 == 1 {
                $1.tabBarItem.image = tabBarIcons[$0]
                $1.tabBarItem.title = "Settings"
            } else if $0 == 2 {
                $1.tabBarItem.image = tabBarIcons[$0]
                $1.tabBarItem.title = "Demo"
                $1.tabBarItem.badgeValue = "11"
            } else {
                fatalError("Unknown tab item")
            }
        }
        window?.rootViewController = tabBarController

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

