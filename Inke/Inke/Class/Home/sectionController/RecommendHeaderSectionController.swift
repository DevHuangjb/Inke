//
//  RecommendHeaderSectionController.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/20.#imageLiteral(resourceName: "WechatIMG1438.png")
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit

class RecommendHeaderSectionController: ListSectionController {
    
    override init() {
        super.init()
//        minimumInteritemSpacing = 5
//        minimumLineSpacing = 5
        inset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let itemW : CGFloat = SCREEN_WIDTH - 10
        return CGSize(width: itemW, height: 49)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommdedHeaderCell",bundle: nil,for: self,at: index) as? RecommdedHeaderCell else {
            fatalError()
        }
        return nibCell                                                           
    }
        
}
