//
//  RootTabBarController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    let viewControllerNames = ["HomeController","NearController","FollowsController","ProfileController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addControllers()
    }
    
    func addControllers()  {
        guard let name = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else{
            return
        }
        for vcName in viewControllerNames {
            let anyClass : AnyClass? = NSClassFromString(name + "." + vcName)
            guard let vcType = anyClass as? UIViewController.Type else {
                return
            }
            let vc = vcType.init()
            vc.title = vcName
            addChildViewController(vc)
        }
    }

}
