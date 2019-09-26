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
        self.view.backgroundColor = .white
        setupChild()
        
    }
    
    func setupChild() {
        let comicsVC = FYComicsViewController.init()
        let communityVC = FYCommunityViewController.init()
        let novelVC = FYNovelViewController.init()
        let meVC = FYMeViewController.init()

        addChild(comicsVC, title: "看漫画", imageName: "", imageSelectName: "")
        addChild(communityVC, title: "逛社区", imageName: "", imageSelectName: "")
        addChild(novelVC, title: "读小说", imageName: "", imageSelectName: "")
        addChild(meVC, title: "我的", imageName: "", imageSelectName: "")
        
    }
    
    func addChild(_ childController: UIViewController,title:String,imageName:String,imageSelectName:String) {
        let navVC = FYNavgationController.init(rootViewController: childController)
        navVC.tabBarItem = UITabBarItem.init(title: title, image:UIImage.init(named: imageName), selectedImage: UIImage.init(named: imageSelectName)?.withRenderingMode(.alwaysOriginal))
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.lightGray], for: .normal)
    navVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], for: .selected)
        
        addChild(navVC)
    }
}
