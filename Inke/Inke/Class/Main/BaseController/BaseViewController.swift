//
//  BaseViewController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
protocol BaseViewControllerProtocol {
    func initUI()
}

class BaseViewController: UIViewController,BaseViewControllerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
//MARK:- 设置UI
    func initUI() {
        view.backgroundColor = UIColor.red
    }

}
