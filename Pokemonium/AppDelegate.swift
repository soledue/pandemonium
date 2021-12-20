//
//  AppDelegate.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = PokemonsViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        } else {
            navigationController.navigationBar.backgroundColor = .clear
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            navigationController.navigationBar.shadowImage = UIImage()
        }
        navigationController.navigationBar.isTranslucent = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

