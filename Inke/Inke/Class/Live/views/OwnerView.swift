//
//  OwnerView.swift
//  Inke
//
//  Created by abiao on 2017/11/5.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit

class OwnerView: UIView {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    class func GetView() -> OwnerView {
        return Bundle.main.loadNibNamed("OwnerView", owner: nil, options: nil)?.first as! OwnerView
    }

}
