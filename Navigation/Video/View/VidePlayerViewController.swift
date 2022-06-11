//
//  VidePlayerViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.06.2022.
//

import UIKit
import youtube_ios_player_helper
import SnapKit

class VidePlayerViewController: UIViewController {
    
    // MARK: PROPERTIES ========================================================================================

    private var videoKey: String
        
    private lazy var playerView: YTPlayerView = {
        let player = YTPlayerView()
        return player
    }()
    
    // MARK: INITS =============================================================================================

    init (videoKey: String) {
        self.videoKey = videoKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        playerView.load(withVideoId: videoKey, playerVars: ["playsinline": "1"])
        setupLayout()
    }
    
    
    // MARK: METHODS =============================================================================================

    private func setupLayout() {
        
        view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.size.width / 1.78)
        }
    }
}

extension VidePlayerViewController: YTPlayerViewDelegate {
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
}
