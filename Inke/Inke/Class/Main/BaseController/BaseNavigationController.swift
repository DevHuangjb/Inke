//
//  BaseNavigationController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏为半透明,从而navController的subControllers的view可以从屏幕顶部开始，如果设置为false则subControllers的view下移64
        self.navigationBar.isTranslucent = true
    }
    
    

}
