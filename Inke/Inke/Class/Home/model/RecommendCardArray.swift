//
//  RecommendCardArray.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/23.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit

class RecommendCardArray: NSObject {
    
    var cards:[RecommendCardModel] = []

}

extension RecommendCardArray: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
    
}
