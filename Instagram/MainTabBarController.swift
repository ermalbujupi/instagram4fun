//
//  MainTabBarController.swift
//  Instagram
//
//  Created by Ermal Bujupaj on 28.11.18.
//  Copyright © 2018 Ermal Bujupaj. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var profileTabBar: UserProfileController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTabBar()
    }
    
    private func setupTabBar() {
        profileTabBar = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let navigationController = UINavigationController(rootViewController: profileTabBar)
        navigationController.tabBarItem.image = UIImage(named: "profile_unselected")
        navigationController.tabBarItem.selectedImage = UIImage(named: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navigationController]
    }

}
