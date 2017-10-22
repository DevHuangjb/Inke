//
//  RecommendCommonSectionController.swift
//  Inke
//
//  Created by abiao on 2017/10/22.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit

class RecommendCommonSectionController: ListSectionController {
    override init() {
        super.init()
                minimumInteritemSpacing = 5
                minimumLineSpacing = 5
        inset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    override func numberOfItems() -> Int {
        return 4
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let itemW : CGFloat = (SCREEN_WIDTH - 15) * 0.5
        return CGSize(width: itemW, height: itemW)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommendLiveGroupCell",bundle: nil,for: self,at: index) as? RecommendLiveGroupCell else {
            fatalError()
        }
        return nibCell
    }
}
