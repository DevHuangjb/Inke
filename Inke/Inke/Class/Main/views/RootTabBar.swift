//
//  RootTabBar.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/17.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class TabBarButton: UIButton {
    private let imageW : CGFloat = 24
    private let contentMargin : CGFloat = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let x = (contentRect.size.width - imageW)*0.5
        return CGRect(x: x, y: contentMargin, width: imageW, height: imageW)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: imageW + contentMargin, width: contentRect.size.width, height: contentRect.size.height - imageW - 2*contentMargin)
    }
}

class RootTabBar: UIView {
    @IBOutlet weak var centerBtn: UIButton!
    var selectedBtn : UIButton?
    
    static func GetView() -> RootTabBar {
        return Bundle.main.loadNibNamed("RootTabBar", owner: nil, options: nil)?.first as! RootTabBar
    }
    
    @IBAction func itemClick(_ sender: UIButton) {
        for subView in self.subviews {
            if let subBtn : UIButton = subView as? UIButton{
                subBtn.isSelected = false
            }
        }
        sender.isSelected = true
        animation(btn: sender)
    }
    
    
    /// 选中按钮动画
    private func animation (btn: UIButton) {
        btn.imageView?.transform = .identity
        if let imageView = btn.imageView, imageView.isAnimating {
            imageView.stopAnimating()
        }
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3, animations: {
                btn.imageView?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 1 / 3, relativeDuration: 1 / 3, animations: {
                btn.imageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2 / 3, relativeDuration: 1 / 3, animations: {
                btn.imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                btn.imageView?.stopAnimating()
            })
        }, completion: nil)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view : UIView? = super.hitTest(point, with: event)
        if !self.isHidden {
            let pointInCenterBtn : CGPoint = convert(point, to: centerBtn)
            if distanceBetweenTwoPoints(point1: CGPoint.init(x: 36, y: 36), point2: pointInCenterBtn) < 32{
                return centerBtn
            }
        }
        return view
    }
    
    @IBAction func centerBtnClick(_ sender: Any) {
        print("center click")
    }
    
    
    
    
}
