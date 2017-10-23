//
//  RecommendLiveCell.swift
//  Inke
//
//  Created by abiao on 2017/10/21.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import SDWebImage

class RecommendLiveCell: UICollectionViewCell {
    
    var model: RecommendCardModel?{
        didSet{
            titleLabel.text = model?.title
            subTitleLabel.text = model?.subTitle
            guard let imageUrl = model?.portrait else {
                return
            }
            avatar.sd_setImage(with: URL.init(string: imageUrl))
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
