//
//  RecommendAdSectionController.swift
//  Inke
//
//  Created by abiao on 2017/10/22.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit

class RecommendAdSectionController: ListSectionController {
    override init() {
        super.init()
//        minimumInteritemSpacing = 5
//        minimumLineSpacing = 5
        inset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let itemW : CGFloat = SCREEN_WIDTH - 10
        return CGSize(width: itemW, height: 130)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommendAdCell",bundle: nil,for: self,at: index) as? RecommendAdCell else {
            fatalError()
        }
        return nibCell
    }
}
