//
//  TabBarController.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import UIKit
import SnapKit
import RxSwift

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbarLayout()
        settupTabbar()
    }


    private func setupTabbarLayout() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 8
        tabBar.layer.masksToBounds = true
        tabBar.tintColor = .primaryColor
    }
    
    private func settupTabbar() {
        let homeViewController = UINavigationController(rootViewController: ViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let preferenceInputViewController = UINavigationController(rootViewController: PreferenceInputViewController())
        
        homeViewController.tabBarItem = UITabBarItem(title: "그룹", image: UIImage(systemName: "person.2"), tag: 0)
        searchViewController.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        preferenceInputViewController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gear"), tag: 2)

        
        setViewControllers([homeViewController, searchViewController, preferenceInputViewController], animated: true)
    }
}

