//
//  ScrollSegmentView.swift
//  Inke
//
//  Created by abiao on 2017/10/19.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class ScrollSegmentView: UIView, UIGestureRecognizerDelegate {
    
    let titles = ["推荐","小视频","王者荣耀","发现","厦门市"]
    var titlewArray : [CGFloat] = []
    var labelArray : [UIView] = []
    
    let itemMargin : CGFloat = 20
    var scrollLive: UIView?
    var startX: CGFloat = 0
    var currentIndex: Int = 0
    var clickFlag : Int = 0
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = randomColor()
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        
        var sumW : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            label.isUserInteractionEnabled = true
            label.tag = index + 100
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.white
            scrollView.addSubview(label)
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
        scrollView.addSubview(scrollLive!)
        scrollLive!.frame = CGRect(x: itemMargin, y: NAV_BAR_HEIGHT - scrollLiveH - bottomPadding, width: titlewArray[0], height: scrollLiveH)
        
        scrollView.contentSize = CGSize(width: sumW, height: 0)
    }
    
    @objc func tapLabel(tapGest : UITapGestureRecognizer) {
        
        let label : UIView = tapGest.view!
        if currentIndex == label.tag - 100 {
            return
        }
        clickFlag = clickFlag + 1;
        scrollToIndex(index: label.tag - 100)
//        contentScrollView?.setContentOffset(CGPoint.init(x: CGFloat(currentIndex) * SCREEN_WIDTH, y: 0), animated: true)
    }
    
    func scrollToIndex(index: Int) {
        var contentOffset : CGFloat = 0
        let destLabel = labelArray[index]
        
        if index == 2 {
            contentOffset = (scrollView.contentSize.width - scrollView.bounds.size.width)*0.5
        }else if index < 2 {
            contentOffset = 0
        }else {
            contentOffset = scrollView.contentSize.width - scrollView.bounds.size.width
        }
        scrollView.setContentOffset(CGPoint.init(x: contentOffset, y: 0), animated: true)
        
        UIView.animate(withDuration: 0.3) {
            self.scrollLive!.frame.origin.x = destLabel.frame.origin.x
            self.scrollLive?.width = self.titlewArray[index]
        }
        currentIndex = index
    }
    
    func scrollToPosition(progress: CGFloat) {
        
        let absProgress = abs(progress)
        var target = Int(ceilf(Float(absProgress)))
        var source = Int(floorf(Float(absProgress)))
        if progress < 0 {
            target = -target
            source = -source
        }
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
