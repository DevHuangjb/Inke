//
//  RecommendAdCell.swift
//  Inke
//
//  Created by abiao on 2017/10/22.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendAdCell: UICollectionViewCell {
    var model:RecommendAdModel?{
        didSet{
            
            guard let tickers = model?.ticker else {
                return
            }
            pageControl.numberOfPages = tickers.count
            scrollView.contentSize = CGSize.init(width: CGFloat(tickers.count) * SCREEN_WIDTH, height: 0)
            let imageW: CGFloat = SCREEN_WIDTH - 10
            for i in 0..<tickers.count{
                let imageView = UIImageView()
                scrollView.addSubview(imageView)
                imageView.frame = CGRect.init(x: CGFloat(i) * imageW, y: 0, width: imageW, height: 110)
                imageView.sd_setImage(with: URL.init(string: tickers[i]["image"].stringValue))
            }
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension RecommendAdCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.width
        pageControl.currentPage = Int(index)
    }
}
