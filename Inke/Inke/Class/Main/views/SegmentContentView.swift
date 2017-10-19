//
//  SegmentContentView.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/19.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class SegmentContentView: UIView {
    
    var startX: CGFloat = 0
    
    var segmentView: ScrollSegmentView?
    
    var vcs: [UIViewController]?{
        didSet{
            scrollView.contentSize = CGSize.init(width: CGFloat(vcs!.count)*SCREEN_WIDTH, height: 0)
            addViewOfController(index: 0)
        }
    }

    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = randomColor()
        scrollView.delegate = self
        return scrollView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
    }
    
    func addViewOfController(index:NSInteger) {
        let vc: UIViewController = vcs![index]
        if vc.isViewLoaded {
            return
        }
        vc.view.frame = CGRect(x:CGFloat(index)*SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: scrollView.height)
        scrollView.addSubview(vc.view)
    }
    
}

extension SegmentContentView: UIScrollViewDelegate {
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
        addViewOfController(index: NSInteger(index))
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        segmentView!.clickFlag = segmentView!.clickFlag - 1
        segmentView!.clickFlag = segmentView!.clickFlag < 0 ? 0 : segmentView!.clickFlag
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        addViewOfController(index: NSInteger(index))
    }
    
}

