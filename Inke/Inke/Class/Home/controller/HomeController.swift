//
//  HomeController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class HomeController: BaseViewController, UIGestureRecognizerDelegate{
    
    let titles = ["推荐","小视频","王者荣耀","发现","厦门市"]
    let itemMargin : CGFloat = 20
    var scrollView : UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView()
        scrollView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80, height: NAV_BAR_HEIGHT)
        scrollView?.backgroundColor = randomColor()
        navigationItem.titleView = scrollView
        
        var sumW : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.tag = index
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.white
            scrollView?.addSubview(label)
            let nstitle : NSString = title as NSString
            let titleW = nstitle.boundingRect(with: CGSize.init(width: 100, height: label.font.lineHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil).size.width
            label.frame = CGRect(x: sumW + itemMargin, y: 0, width: titleW, height: NAV_BAR_HEIGHT)
            sumW += titleW + itemMargin
            
            let tapGest = UITapGestureRecognizer()
            tapGest.delegate = self
            label.addGestureRecognizer(tapGest)
            tapGest.addTarget(self, action: #selector(tapLabel(tapGest:)))
        }
        sumW += itemMargin
        scrollView?.contentSize = CGSize(width: sumW, height: 0)
    }
    
    @objc func tapLabel(tapGest : UITapGestureRecognizer) {
        let label : UIView = tapGest.view!
        scrollView?.setContentOffset(label.frame.origin, animated: true)
    }

}
