//
//  FYTabBarController.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class FYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        setupChild()
        
    }
    
    func setupChild() {
        let comicsVC = FYComicsViewController.init()
        let communityVC = FYCommunityViewController.init()
        let novelVC = FYNovelViewController.init()
        let meVC = FYMeViewController.init()

        addChild(comicsVC, title: "", imageName:"tab_home", imageSelectName: "tab_home_S")
        addChild(communityVC, title: "", imageName: "tab_class", imageSelectName: "tab_class_S")
        addChild(novelVC, title: "", imageName: "tab_book", imageSelectName: "tab_book_S")
        addChild(meVC, title: "", imageName: "tab_mine", imageSelectName: "tab_mine_S")
        
    }
    
    func addChild(_ childController: UIViewController,title:String,imageName:String,imageSelectName:String) {
        let navVC = FYNavgationController.init(rootViewController: childController)
        navVC.tabBarItem = UITabBarItem.init(title: title, image:UIImage.init(named: imageName)!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: imageSelectName)?.withRenderingMode(.alwaysOriginal))
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], for: .selected)
        
        addChild(navVC)
    }
}
extension FYTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
