//
//  RecommendHeaderSectionController.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/20.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit

class RecommendHeaderSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 44)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommdedHeaderCell",bundle: nil,for: self,at: index) as? RecommdedHeaderCell else {
            fatalError()
        }
        return nibCell
                                                                    
    }
        
}
