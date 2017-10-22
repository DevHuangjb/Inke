//
//  NetworkTools.swift
//  Inke
//
//  Created by abiao on 2017/10/22.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import Alamofire

let card_recommend: String = "http://218.11.0.112/api/live/card_recommend?user_level=1&longitude=118.165645&live_uid=0&stay_time=0&latitude=24.492529&type=0&slide_pos=0&location=CN%2C%E7%A6%8F%E5%BB%BA%E7%9C%81%2C%E5%8E%A6%E9%97%A8%E5%B8%82&refurbish_mode=0&city_tab_key=4CB448717950AEC5%2C%E5%8E%A6%E9%97%A8&card_pos=0&gender=1&lc=0000000000000074&cc=TG0001&cv=IK5.0.05_Iphone&proto=8&idfa=34EE495C-D4E8-4E54-A69C-748927790875&idfv=96CAB405-C443-41B7-94C7-D94175465B67&devi=f6ff275f90a2460acdc3ce86472713986f741da8&osversion=ios_10.300000&ua=iPhone7_1&imei=&imsi=&uid=597087307&sid=202oy4nfwMSrLZgDwNjvqi0z801V8uoL68bojf3ti0ZdmvrJrU9U&conn=wifi&mtid=5905002eadd2ea829f4ad9b34bb7b8bc&mtxid=8cf228df1590&logid=259,264,226,229&s_sg=212a486dbf2e86a0e69ab35fcd4146be&s_sc=100&s_st=1508664288"

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, success :  @escaping (_ result : [String : AnyObject]?) -> (), failure :  @escaping (_ error : Error?) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
//            // 3.获取结果
//            guard let result = response.result.value else {
//                failure(response.result.error)
//                return
//            }
//            // 4.将结果回调出去
//            success(result)
            switch response.result {
            case.success:
                if let value = response.result.value as? [String : AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failure(error)
            }
        }
        
    }
}
