//
//  MainTabBarController.swift
//  Pokemon
//
//  Created by Deonte on 10/13/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavAndTabBar()
        setupViewControllers()
    }

    // MARK:- Helper Functions
    
    fileprivate func generateControllers(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navController.tabBarItem.image = image
        //navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemRed]
        //navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.systemRed]
        return navController
    }
    
    fileprivate func setupViewControllers() {
        viewControllers = [
            generateControllers(with: PokemonController(), title: "Pokémon", image: #imageLiteral(resourceName: "pokemon-tabBar-active")),
            generateControllers(with: MovesController(), title: "Moves", image: #imageLiteral(resourceName: "moves-tabBar-active")),
            generateControllers(with: ItemsController(), title: "Items", image: #imageLiteral(resourceName: "items-tabBar-active"))
        ]
    }
    
    fileprivate func setupNavAndTabBar() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .systemRed
        tabBar.tintColor = .systemRed
    }
    
    
}
