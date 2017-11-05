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
    var segmentView: ScrollSegmentView?
    var contentView: SegmentContentView?
    var contentScrollView : UIScrollView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        setNavBarToMain()
        setupTitleScrollView()
        setupContentScrollView()
    }
    
    func setupContentScrollView() {
        var vcs: [UIViewController] = []
        let vcClasses = [RecommendController.self,VideoController.self,HotGameController.self,FoundController.self,LocalCityController.self]
        contentView = SegmentContentView(frame: CGRect(x: 0, y: TOP_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TOP_HEIGHT))
        contentView?.segmentView = segmentView
        for vcType in vcClasses{
            let vc = vcType.init()
            addChildViewController(vc)
            vcs.append(vc)
        }
        contentView?.vcs = vcs
        view.addSubview(contentView!)
    }
    
    func setupTitleScrollView() {
        segmentView = ScrollSegmentView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80, height: NAV_BAR_HEIGHT))
        navigationItem.titleView = segmentView
        segmentView?.delegate = self
        segmentView?.titles = titles
    }

}

extension HomeController: ScrollSegmentDelegate {
    func scrollSegmentViewSelectedItem(segmentView: ScrollSegmentView, selectedIdx: NSInteger) {
        contentView?.scrollView.setContentOffset(CGPoint.init(x: CGFloat(selectedIdx) * SCREEN_WIDTH, y: 0), animated: true)
    }
}







