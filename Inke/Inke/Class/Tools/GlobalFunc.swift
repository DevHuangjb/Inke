//
//  GlobalFunc.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/17.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import Foundation


/// 字符串转类
func ClassFromString(className: String) -> AnyClass? {
    guard let bundleName = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String else{
        return nil
    }
    let anyClass : AnyClass? = NSClassFromString(bundleName + "." + className)
    return anyClass
}

///计算两点间的距离
func distanceBetweenTwoPoints(point1:CGPoint,point2:CGPoint) -> CGFloat {
    let xDist : CGFloat = (point1.x - point2.x)
    let yDist : CGFloat = (point1.y - point2.y)
    let distance : CGFloat = sqrt((xDist * xDist) + (yDist * yDist))
    return distance
}

///随机颜色
func randomColor () -> UIColor {
    return UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
}
