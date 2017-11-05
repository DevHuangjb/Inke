//
//  LiveRoomController.swift
//  Inke
//
//  Created by abiao on 2017/11/5.
//  Copyright © 2017年 DevHuangjb. All rights reserved.
//

import UIKit
import IJKMediaFramework
import SwiftyJSON
import SnapKit

class LiveRoomController: UIViewController {
//    @property(atomic, retain) id<IJKMediaPlayback> player;
    var player : IJKMediaPlayback?
    var loadBlurImage: UIImageView?
    var watcherScrollView : UIScrollView?
    
    var model:RecommendCardModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
        installMovieNotificationObservers()
        player?.prepareToPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeMovieNotificationObservers()
        player?.shutdown()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup fter loading the view.
        initUI()
        initPlayer()
        initTopView()
        
        NetworkTools.requestData(.get, URLString: liveUserApiGet(id: (model?.id)!), parameters: nil, success: { (result) in
            self.setupWatchers(result: result!)
        }) { (error) in
            print(error!)
        }
    }
    
    func setupWatchers(result: [String : AnyObject]) {
        let json = JSON(result)
        let users = json["users"].arrayValue
        let iconMargin = 5
        for (idx,user) in users.enumerated() {
//            print(user["portrait"].stringValue)
            let iconView = UIImageView()
            iconView.frame = CGRect(x: idx * (34 + iconMargin), y: 0, width: 34, height: 34)
            iconView.layer.cornerRadius = 17
            iconView.clipsToBounds = true
            watcherScrollView?.addSubview(iconView)
            iconView.sd_setImage(with: URL.init(string: user["portrait"].stringValue))
        }
        watcherScrollView?.contentSize = CGSize(width: users.count * (iconMargin + 34), height: 0)
    }
    
    func initTopView() {
        let topView = UIView()
        topView.frame = CGRect(x: 0, y: 20, width: SCREEN_WIDTH, height: 60)
        view.addSubview(topView)
        view.backgroundColor = UIColor.clear
        
        let bottomTool = BottomToolBox.GetView()
        bottomTool.delegate = self
        view.addSubview(bottomTool)
        bottomTool.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(30)
            make.leading.equalTo(0)
            make.bottom.equalTo(-10)
        }
        
        let ownerViewH : CGFloat = 34
        let margin : CGFloat = 10
        let ownerView = OwnerView.GetView()
        ownerView.iconView.sd_setImage(with: URL.init(string: (model?.portrait)!))
        ownerView.nameLabel.text = model?.title
        ownerView.totalLabel.text = model?.subTitle
        ownerView.frame = CGRect(x: margin, y: 0, width: 120, height: ownerViewH)
        topView.addSubview(ownerView)
        
        watcherScrollView = UIScrollView()
        let watchX : CGFloat = margin * 2 + 120
        watcherScrollView?.showsHorizontalScrollIndicator = false
        watcherScrollView!.frame = CGRect(x: watchX, y: 0, width: SCREEN_WIDTH - watchX, height: ownerViewH)
        topView.addSubview(watcherScrollView!)
    }
    
    func initUI() {
        view.backgroundColor = UIColor.black
        initBlurImage()
    }
    
    func initBlurImage() {
        loadBlurImage = UIImageView(frame: SCREEN_BOUNDS)
        loadBlurImage!.sd_setImage(with: URL.init(string: (model?.portrait)!))
        view.addSubview(loadBlurImage!)
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = SCREEN_BOUNDS
        loadBlurImage?.addSubview(effectView)
    }
    
    func initPlayer() {
        let options = IJKFFOptions.byDefault()
        player = IJKFFMoviePlayerController(contentURLString: model?.stream_addr, with: options)
        player?.view.frame = SCREEN_BOUNDS
        player?.shouldAutoplay = true
        view.addSubview((player?.view)!)
    }
    
    @objc func loadStateDidChange() {
        print("loadStateDidChange")
    }
    
    @objc func moviePlayBackDidFinish() {
        print("moviePlayBackDidFinish")
    }
    
    @objc func mediaIsPreparedToPlayDidChange() {
        print("mediaIsPreparedToPlayDidChange")
    }
    
    @objc func moviePlayBackStateDidChange() {
        print("moviePlayBackStateDidChange")
        loadBlurImage?.isHidden = true
        loadBlurImage?.removeFromSuperview()
    }

    
    /* Register observers for the various movie object notifications. */
    func installMovieNotificationObservers() {
        
    }
    /* Remove the movie notification observers from the movie object. */
    func removeMovieNotificationObservers() {

    }
    
//    /* Register observers for the various movie object notifications. */
//    -(void)installMovieNotificationObservers
//    {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(loadStateDidChange:)
//    name:IJKMPMoviePlayerLoadStateDidChangeNotification
//    object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(moviePlayBackDidFinish:)
//    name:IJKMPMoviePlayerPlaybackDidFinishNotification
//    object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(mediaIsPreparedToPlayDidChange:)
//    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
//    object:_player];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//    selector:@selector(moviePlayBackStateDidChange:)
//    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
//    object:_player];
//    }
//
//    #pragma mark Remove Movie Notification Handlers
//
//    /* Remove the movie notification observers from the movie object. */
//    -(void)removeMovieNotificationObservers
//    {
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
//    }
    
}

extension LiveRoomController : BottomToolBoxDelegate {
    func bottomToolBoxClick(idx: Int) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
