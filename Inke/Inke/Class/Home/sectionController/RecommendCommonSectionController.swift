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
    
    var cardArray:RecommendCardArray?
    
    override init() {
        super.init()
                minimumInteritemSpacing = 5
                minimumLineSpacing = 5
        inset = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
    }
    
    override func numberOfItems() -> Int {
        return (cardArray?.cards.count)!
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let itemW : CGFloat = (SCREEN_WIDTH - 15) * 0.5
        return CGSize(width: itemW, height: itemW)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        let model = cardArray?.cards[index]
        if model?.style == 1 {
            guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommendLiveCell",bundle: nil,for: self,at: index) as? RecommendLiveCell else {
                fatalError()
            }
            nibCell.model = model
            return nibCell
        }else{
            guard let nibCell = collectionContext?.dequeueReusableCell(withNibName: "RecommendLiveGroupCell",bundle: nil,for: self,at: index) as? RecommendLiveGroupCell else {
                fatalError()
            }
            nibCell.model = model
            return nibCell
        }
    }
    
    override func didUpdate(to object: Any) {
        guard let objModel = object as? RecommendCardArray  else {
            return
        }
        cardArray = objModel
    }
}
