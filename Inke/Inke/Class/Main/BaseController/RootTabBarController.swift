//
//  RootTabBarController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    var tabbar: RootTabBar?
    
    let viewControllerNames = ["HomeController","NearController","FollowsController","ProfileController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /// 设置ui
    func initUI() {
        addControllers()
        setupTabBar()
    }
    
    /// 设置Tabbar
    func setupTabBar() {
        tabBar.isHidden = true
        tabbar = RootTabBar.GetView()
        view.addSubview(tabbar!)
        tabbar?.frame = CGRect(x: 0, y: SCREEN_HEIGHT - TAB_BAR_HEIGHT, width:SCREEN_WIDTH , height:TAB_BAR_HEIGHT)
        tabbar?.delegate = self
    }
    
    /// 添加子视图
    func addControllers()  {
        for vcName in viewControllerNames {
            guard let vcType = ClassFromString(className: vcName) as? UIViewController.Type else {
                return
            }
            let vc = vcType.init()
            let nav = BaseNavigationController.init(rootViewController: vc)
            nav.delegate = self
            addChildViewController(nav)
        }
    }
    
    func setTabBarHider(hidden: Bool) {
        UIView.animate(withDuration: 0.25) {
            if hidden {
                self.tabbar?.y = SCREEN_HEIGHT + 30
            }else {
                self.tabbar?.y = SCREEN_HEIGHT - TAB_BAR_HEIGHT
            }
        }
    }
}

extension RootTabBarController: RootTabBarDelegate {
    func rootTabBarSelectedIndex(index: Int){
        selectedIndex = index
    }
}

extension RootTabBarController: UINavigationControllerDelegate{
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setTabBarHider(hidden: navigationController.viewControllers.count > 1)
    }
}
