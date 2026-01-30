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
        let navigationController = UINavigationController(rootViewController: homeController)
        navigationController.tabBarItem = .init(title: "Home",
                                                image: .init(systemName: "house.fill"),
                                                tag: 0)
        
        viewControllers = [navigationController]
    }
    
    private func configureTabbarUI() {
        tabBar.backgroundColor = .white
    }
}
