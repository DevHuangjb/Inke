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
    var titlewArray : [CGFloat] = []
    var labelArray : [UIView] = []
    
    let itemMargin : CGFloat = 20
    var scrollView : UIScrollView?
    var contentScrollView : UIScrollView?
    var scrollLive: UIView?
    var startX: CGFloat = 0
    var currentIndex: Int = 0
    var clickFlag : Bool = false
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
        
        scrollView = UIScrollView()
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 80, height: NAV_BAR_HEIGHT)
        scrollView?.backgroundColor = randomColor()
        navigationItem.titleView = scrollView
        
        var sumW : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.tag = index + 100
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
            titlewArray.append(titleW)
            labelArray.append(label)
        }
        sumW += itemMargin
        
        let scrollLiveH: CGFloat = 2
        let bottomPadding: CGFloat = 4
        scrollLive = UIView()
        scrollLive!.backgroundColor = UIColor.white
        scrollView!.addSubview(scrollLive!)
        scrollLive!.frame = CGRect(x: itemMargin, y: NAV_BAR_HEIGHT - scrollLiveH - bottomPadding, width: titlewArray[0], height: scrollLiveH)
        
        scrollView?.contentSize = CGSize(width: sumW, height: 0)
    }
    
    @objc func tapLabel(tapGest : UITapGestureRecognizer) {
        
        let label : UIView = tapGest.view!
        clickFlag = true
        scrollToIndex(index: label.tag - 100)
        
    }
    
    func scrollToIndex(index: Int) {
        var contentOffset : CGFloat = 0
        let destLabel = labelArray[index]
        
        if index == 2 {
            contentOffset = (scrollView!.contentSize.width - scrollView!.bounds.size.width)*0.5
        }else if index < 2 {
            contentOffset = 0
        }else {
            contentOffset = scrollView!.contentSize.width - scrollView!.bounds.size.width
        }
        scrollView?.setContentOffset(CGPoint.init(x: contentOffset, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.scrollLive!.frame.origin.x = destLabel.frame.origin.x
            self.scrollLive?.width = self.titlewArray[index]
        }
        currentIndex = index
        if clickFlag {
            contentScrollView?.setContentOffset(CGPoint.init(x: CGFloat(currentIndex) * SCREEN_WIDTH, y: 0), animated: true)
        }
    }
    
    func scrollToPosition(progress: CGFloat, sourceIdx:CGFloat, targetIdx: CGFloat,offset:CGFloat) {
        
        let absProgress = abs(progress)
        var target = Int(ceilf(Float(absProgress)))
        var source = Int(floorf(Float(absProgress)))
        if progress < 0 {
            target = -target
            source = -source
        }
        let setpIndex = Int(ceilf(Float(absProgress)))
        var total: CGFloat = 0
        
        total = labelArray[currentIndex + target].x - labelArray[currentIndex + source].x
        var stepX : CGFloat = 0
        if progress > 0 {
            stepX = total * (progress - CGFloat(source))
        }else{
            stepX = -total * (progress - CGFloat(source))
        }
        if stepX.isNaN {
            scrollLive?.x = labelArray[currentIndex + source].x
        }else{
            scrollLive?.x = labelArray[currentIndex + source].x + stepX
        }

        let totalW = titlewArray[currentIndex + target] - titlewArray[currentIndex + source]
        var stepW: CGFloat = 0
        if progress > 0 {
            stepW = totalW * (progress - CGFloat(source))
        }else{
            stepW = -totalW * (progress - CGFloat(source))
        }
        if stepW.isNaN {
            scrollLive?.width = titlewArray[currentIndex + source]
        }else{
            scrollLive?.width = titlewArray[currentIndex + source] + stepW
        }
        
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
        if clickFlag {
            return
        }
        let progress = (scrollView.contentOffset.x - startX)/SCREEN_WIDTH
        scrollToPosition(progress: progress, sourceIdx: 0, targetIdx: 0,offset: scrollView.contentOffset.x)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        scrollToIndex(index: Int(index))
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        clickFlag = false
    }
    
}


