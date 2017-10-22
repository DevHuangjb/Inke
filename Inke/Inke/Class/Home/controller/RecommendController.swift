//
//  RecommendController.swift
//  Inke
//
//  Created by huangjinbiao on 2017/10/19.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IGListKit
import SwiftyJSON

class RecommendController: BaseViewController, ListAdapterDataSource {
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //0:在看 1：在直播 2：headerview 3：scroll
//    let data: [Any] = [
//        "2","0","1","0","0","3","0","1","1","0","0","0","0","0","0","0","0","0","0","0","0","0","0","0"
//    ]
    var data: [RecommendCardModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = randomColor()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        
        NetworkTools.requestData(.get, URLString: card_recommend, parameters: nil, success: { (result) in
            guard let temp = result else {
                return
            }
            let json = JSON(temp)
            let cards = json["cards"].arrayValue
            for card in cards {
                let cardModel = RecommendCardModel(json: card)
                if cardModel.style == 1 || cardModel.style == 4 {
                    self.data.append(cardModel)
                }
            }
            self.adapter.performUpdates(animated: true, completion: nil)
        }) { (error) in
            print(error!)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        collectionView.backgroundColor = UIColor.white
        

    }
    
    // MARK:- ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
//        return data.map { $0 as! ListDiffable}
        var tempArr:Array = [Any]()
        tempArr.append("header")
        tempArr.append("ad")
        if data.count > 0 {
            tempArr.append(data)
        }
        return tempArr.map { $0 as! ListDiffable}
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if let str: String = object as? String {
            if str.hasPrefix("header"){
                return RecommendHeaderSectionController()
            }else if str.hasPrefix("ad") {
                return RecommendAdSectionController()
            }
        }
        
        return RecommendCommonSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}
