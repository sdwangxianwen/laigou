//
//  FYBaseViewController.swift
//  qhm
//
//  Created by wang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit



class FYBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           configNavigationBar()
       }
    
    func configNavigationBar() {
           guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "nav_back_white"), style: .plain, target: self, action: #selector(pressBack))
            }
           }
       }
    @objc func pressBack() {
          navigationController?.popViewController(animated: true)
      }
}

extension FYBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
