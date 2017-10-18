//
//  HomeController.swift
//  Inke
//
//  Created by abiao on 2017/10/16.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class HomeController: BaseViewController, UIGestureRecognizerDelegate{
    var segmentView: ScrollSegmentView?
    var contentScrollView : UIScrollView?
    var startX: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        setupTitleScrollView()
        setupContentScrollView()
        
    }
    
    func setupContentScrollView() {
        contentScrollView = UIScrollView()
        contentScrollView?.bounces = false
//        scrollView!.showsHorizontalScrollIndicator = false
        contentScrollView?.isPagingEnabled = true
        contentScrollView!.frame = CGRect(x: 0, y: TOP_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TOP_HEIGHT - TAB_BAR_HEIGHT)
        contentScrollView!.backgroundColor = randomColor()
        view.addSubview(contentScrollView!)
        contentScrollView?.contentSize = CGSize.init(width: 5*SCREEN_WIDTH, height: 0)
        contentScrollView?.delegate = self
        
    }
    
    func setupTitleScrollView() {
        segmentView = ScrollSegmentView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80, height: NAV_BAR_HEIGHT))
        navigationItem.titleView = segmentView
    }

}

extension HomeController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isDecelerating {
            return
        }
        startX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if segmentView!.clickFlag > 0 {
            return
        }
        let progress = (scrollView.contentOffset.x - startX)/SCREEN_WIDTH
        segmentView?.scrollToPosition(progress: progress)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        segmentView?.scrollToIndex(index: Int(index))
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        segmentView!.clickFlag = segmentView!.clickFlag - 1
        segmentView!.clickFlag = segmentView!.clickFlag < 0 ? 0 : segmentView!.clickFlag
    }
    
}


