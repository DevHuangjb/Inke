//
//  ScrollSegmentView.swift
//  Inke
//
//  Created by abiao on 2017/10/19.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

let itemMargin: CGFloat = 20
let itemFontSize: CGFloat = 15.0

protocol ScrollSegmentDelegate: NSObjectProtocol {
    func scrollSegmentViewSelectedItem(segmentView: ScrollSegmentView, selectedIdx: NSInteger)
}

class ScrollSegmentView: UIView, UIGestureRecognizerDelegate {
    
    var titles: [String]?{
        didSet{
            var sumW : CGFloat = 0
            for (index,title) in titles!.enumerated() {
                let label = UILabel()
                label.isUserInteractionEnabled = true
                label.tag = index + 100
                label.text = title
                label.font = UIFont.systemFont(ofSize: itemFontSize)
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
            if sumW < scrollView.width {
                var paddingH : CGFloat = (scrollView.width - sumW + 2*itemMargin) * 0.5
                for (index,w) in titlewArray.enumerated() {
                    labelArray[index].x = paddingH
                    paddingH += w + itemMargin
                }
            }
            scrollView.contentSize = CGSize(width: sumW, height: 0)
            scrollLine.frame = CGRect(x: labelArray[0].x, y: NAV_BAR_HEIGHT - 3 - 6, width: titlewArray[0], height: 3)
            scrollToIndex(index: 0)
        }
    }
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.white
        scrollLine.layer.masksToBounds = true
        scrollLine.layer.cornerRadius = 1.5
        return scrollLine
    }()
    
    var titlewArray : [CGFloat] = []
    var labelArray : [UILabel] = []
    
    var currentIndex: Int = 0
    var clickFlag : Int = 0
    
    weak var delegate: ScrollSegmentDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        scrollView.addSubview(scrollLine)
    }
    
    @objc func tapLabel(tapGest : UITapGestureRecognizer) {
        
        let label : UIView = tapGest.view!
        if currentIndex == label.tag - 100 {
            return
        }
        clickFlag = clickFlag + 1;
        scrollToIndex(index: label.tag - 100)
        delegate?.scrollSegmentViewSelectedItem(segmentView: self, selectedIdx: label.tag - 100)
    }
    
    func scrollToIndex(index: Int) {
        var contentOffset : CGFloat = 0
        let destLabel = labelArray[index]
        let sourceLabel = labelArray[currentIndex]
        
        sourceLabel.font = UIFont.systemFont(ofSize: itemFontSize)
        destLabel.font = UIFont.boldSystemFont(ofSize: itemFontSize)
        
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = destLabel.frame.origin.x
            self.scrollLine.width = self.titlewArray[index]
        }
        currentIndex = index
        
        if scrollView.contentSize.width < scrollView.width {
            return
        }
        if destLabel.center.x > scrollView.width * 0.5 {
            contentOffset = destLabel.center.x - scrollView.width * 0.5
        }
        if (scrollView.contentSize.width - destLabel.center.x) < scrollView.width * 0.5 {
            contentOffset = scrollView.contentSize.width - scrollView.width
        }
        scrollView.setContentOffset(CGPoint.init(x: contentOffset, y: 0), animated: true)
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
            scrollLine.x = labelArray[currentIndex + source].x
        }else{
            scrollLine.x = labelArray[currentIndex + source].x + stepX
        }
        
        let totalW = titlewArray[currentIndex + target] - titlewArray[currentIndex + source]
        var stepW: CGFloat = 0
        if progress > 0 {
            stepW = totalW * (progress - CGFloat(source))
        }else{
            stepW = -totalW * (progress - CGFloat(source))
        }
        if stepW.isNaN {
            scrollLine.width = titlewArray[currentIndex + source]
        }else{
            scrollLine.width = titlewArray[currentIndex + source] + stepW
        }
        
    }

}
