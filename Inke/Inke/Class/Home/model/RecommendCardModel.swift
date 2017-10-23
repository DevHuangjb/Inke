//
//  RecommendCardModel.swift
//  Inke
//
//  Created by abiao on 2017/10/22.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import SwiftyJSON
import IGListKit

class RecommendCardModel: NSObject {
    
    var cover : [String:Any]?
    var data : [String:Any]?
    var style: Int = 0
    var title: String?
    var subTitle:String = ""
    var bg_image: String?
    var icon: String?
    var portrait: String?
    var subPortraits:[String] = []
    var numOfGroup: Int = 0
    init(json: JSON) {
        cover = json["cover"].dictionaryValue
        data = json["data"].dictionaryValue
        style = json["cover"]["style"].intValue
        if style == 1 {
            portrait = json["data"]["live_info"]["creator"]["portrait"].stringValue
        }
        if style == 4 {
            portrait = json["data"]["channel"]["cards"][0]["creator"]["portrait"].stringValue
            let portraits = json["data"]["channel"]["cards"].arrayValue
            for portrait in portraits {
                subPortraits.append(portrait["creator"]["portrait"].stringValue)
            }
        }
        let elements = json["cover"]["elements"].arrayValue
        for (idx,elementsJson) in elements.enumerated() {
            if idx == 0{
                title = elementsJson["text"].stringValue
                bg_image = elementsJson["bg_image"].stringValue
                let iconJson = elementsJson["icon"].arrayValue
                if iconJson.count > 0 {
                    icon = iconJson[0].stringValue
                }
                continue
            }
            if idx == 1 {
                numOfGroup = elementsJson["text"].intValue
            }
            subTitle += elementsJson["text"].stringValue
        }
    }

}

