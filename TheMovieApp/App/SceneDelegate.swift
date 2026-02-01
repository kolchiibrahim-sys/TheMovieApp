//
//  SceneDelegate.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 30.01.26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
       setRootController(windowScene: windowScene)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = TabbarController()
        window?.makeKeyAndVisible()
    }
    
    private func setRootController(windowScene: UIWindowScene) {
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}

