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
    var test: [String] = ["1","2"]
    var adModel : RecommendAdModel?
    var topTotal = 0

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
            for (idx,card) in cards.enumerated() {
                let style = card["cover"]["style"].intValue
                if style == 6 {
                    self.adModel = RecommendAdModel(json: card)
                    self.topTotal = idx
                    continue
                }
                
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
        let cards = RecommendCardArray()
        let cardbottom = RecommendCardArray()

        var items: [ListDiffable] = ["header" as ListDiffable]
        if data.count > 0 {
            var top4:[RecommendCardModel] = []
            for i in 0...topTotal-1 {
                top4.append(data[i])
            }
            cards.cards = top4
            var dataBottom:[RecommendCardModel] = []
            for i in topTotal..<data.count {
                dataBottom.append(data[i])
            }
            cardbottom.cards = dataBottom
            items.append(cards as ListDiffable)
            if let admodel = adModel {
                items.append(admodel as ListDiffable)
            }
            
            items.append(cardbottom as ListDiffable)
        }
        
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        if object is String {
            return RecommendHeaderSectionController()
        }else if object is RecommendAdModel {
            return RecommendAdSectionController()
        }
        return RecommendCommonSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}
