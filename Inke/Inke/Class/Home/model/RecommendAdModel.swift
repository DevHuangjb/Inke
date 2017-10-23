//
//  RecommendAdModel.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/23.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import SwiftyJSON
import IGListKit

class RecommendAdModel: NSObject {
    
    var style: Int = 0
    var ticker: [JSON]?
    
    init(json: JSON) {
        style = json["cover"]["style"].intValue
        ticker = json["data"]["ticker"].arrayValue
    }
}

extension RecommendAdModel: ListDiffable {
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return self === object ? true : self.isEqual(object)
    }
    
}
