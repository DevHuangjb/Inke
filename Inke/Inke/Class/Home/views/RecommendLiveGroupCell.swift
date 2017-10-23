//
//  RecommendLiveGroupCell.swift
//  Inke
//
//  Created by abiao on 2017/10/21.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import SDWebImage

class RecommendLiveGroupCell: UICollectionViewCell {
    
    var model: RecommendCardModel?{
        didSet{
            guard let tempModel = model else {
                return
            }
            
            if let imageUrl = tempModel.portrait {
                avatar.sd_setImage(with: URL.init(string: imageUrl))
            }
            if let bgUrl = tempModel.bg_image {
                bg_imageView.sd_setImage(with: URL.init(string: bgUrl))
            }
            
            title.text = tempModel.title
            subTitle.text = tempModel.subTitle
            let indicatorW : Int = tempModel.numOfGroup > 80 ? 80 : tempModel.numOfGroup
            numIndicatorW.constant = CGFloat(indicatorW)
            if let iconUrl = tempModel.icon {
                icon.sd_setImage(with: URL.init(string: iconUrl))
            }
            
            let subAvatar = tempModel.subPortraits
            for i in 0..<subAvatar.count {
                if i == 1 {
                    smallAvatar1.sd_setImage(with: URL.init(string: subAvatar[i]))
                }
                if i == 2 {
                    smallAvatar1.sd_setImage(with: URL.init(string: subAvatar[i]))
                }
                if i == 3 {
                    smallAvatar1.sd_setImage(with: URL.init(string: subAvatar[i]))
                }
            }
            
        }
    }
    
    @IBOutlet weak var bg_imageView: UIImageView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var smallAvatar1: UIImageView!
    @IBOutlet weak var smallAvatar2: UIImageView!
    @IBOutlet weak var smallAvatar3: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var numIndicatorW: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
