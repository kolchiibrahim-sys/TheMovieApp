//
//  TabbarController.swift
//  TheMovieApp
//
//  Created by Kolchı Ibrahım on 31.01.26.
//
import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabbarUI()
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        let homeController = HomeController()
        let homeNav = UINavigationController(rootViewController: homeController)
        homeNav.tabBarItem = .init(title: "Home",
                                   image: .init(systemName: "house.fill"),
                                   tag: 0)
        
        let actorController = ActorController()
        let actorNav = UINavigationController(rootViewController: actorController)
        actorNav.tabBarItem = .init(title: "Actors",
                                    image: .init(systemName: "person.fill"),
                                    tag: 1)
        
        viewControllers = [homeNav, actorNav]
    }
    
    private func configureTabbarUI() {
        tabBar.backgroundColor = .white
    }
}
