//
//  BottomToolBox.swift
//  Inke
//
//  Created by abiao on 2017/11/6.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

protocol BottomToolBoxDelegate : NSObjectProtocol{
    func bottomToolBoxClick(idx: Int)
}

class BottomToolBox: UIView {
    weak var delegate:BottomToolBoxDelegate?

    class func GetView() -> BottomToolBox {
        return Bundle.main.loadNibNamed("BottomToolBox", owner: nil, options: nil)?.first as! BottomToolBox
    }
    @IBAction func itemClick(_ sender: UIButton) {
        delegate?.bottomToolBoxClick(idx: sender.tag)
    }
    
}
