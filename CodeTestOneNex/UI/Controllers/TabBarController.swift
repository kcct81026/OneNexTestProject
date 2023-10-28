//
//  TabBarController.swift
//  CodeTestOneNex
//
//  Created by AyeSuNaing on 27/10/2023.
//

import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate, UIPageViewControllerDelegate {
    var pageViewController: UIPageViewController!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTabs()

        self.tabBar.tintColor = UIColor(named: "appbarcolor")
        self.tabBar.unselectedItemTintColor = .gray
        self.delegate = self
        
        

    }


    private func setupTabs(){
        let controllers = [
            self.createNav(with: "Home", and: UIImage(systemName: "house.fill"), vc: HomeViewController()),
            self.createNav(with: "Discover", and: UIImage(systemName: "map.circle"), vc: DiscoverViewController()),
            self.createNav(with: "Collect/Pay", and: UIImage(systemName: "qrcode.viewfinder"), vc: CollectViewController()),
            self.createNav(with: "My Pocket", and: UIImage(systemName: "menucard"), vc: PocketViewController()),
            self.createNav(with: "Settings", and: UIImage(systemName: "gear"), vc: SettingsViewController())
        ]
   

        self.setViewControllers(controllers, animated: true)

    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)

        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        nav.viewControllers.first?.navigationItem.title = title + " ViewController"
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)

        return nav
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }



}
