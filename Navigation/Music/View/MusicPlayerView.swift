//
//  MusicPlayerView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
//import AVFoundation
import SnapKit

protocol PlayerDelegate: AnyObject {
    
    func setTrack ()
    func playPause ()
    func stop ()
    func nextTrack ()
    func previousTrack ()
    func playSelectedTrack(forIndex index: Int)

}

class MusicPlayerView: UIView {
    
    // MARK: PROPERTIES =============================================================================================
    
    weak var delegate: PlayerDelegate?
    
    private var trackName: String {
        get {
            return MusicViewModel.shared.currentTrackName
        }
    }
    
    private var model = MusicViewModel()

    private lazy var playPauseButton = getButton(icon: "play.fill", action: #selector(playPauseButtonAction))
    private lazy var stopButton = getButton(icon: "stop.fill", action: #selector(stopButtonAction))
    private lazy var nextTrackButton = getButton(icon: "forward.fill", action: #selector(nextTrackAction))
    private lazy var previousTrackButton = getButton(icon: "backward.fill", action: #selector(previousTrackAction))
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ничего не проигрывается"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var playerButtonsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                previousTrackButton,
                playPauseButton,
                stopButton,
                nextTrackButton
            ])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    
    // MARK: INITS =================================================================================================
    
    init () {
        super.init(frame: .zero)
        addSubviews(playerButtonsStackView, trackNameLabel)
        setuplayout()
        delegate?.setTrack()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playPauseButtonAction),
            name: NSNotification.Name.playPause,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS =================================================================================================
    
//    private func setTrack() {
//        let trackName = Array(MusicViewModel.shared.tracks.keys)[MusicViewModel.shared.counter]
//        
//        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
//        
//        do {
//            try player = AVAudioPlayer(contentsOf: trackURL)
//            player.prepareToPlay()
//            
//        } catch { print(error.localizedDescription) }
//        
//        trackNameLabel.text = currentTrackName
//    }
    
    
//    public func playSelectedTrack (forIndex index: Int) {
//        counter = index
//        setTrack()
//        player.play()
//        playPauseButton.setCustomImage(name: "pause.fill", size: 32)
//    }
    
    private func setuplayout() {
        
        playerButtonsStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(32)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(playerButtonsStackView.snp.top).offset(-32)
        }
    }
    
    func setTrackName() {
//        trackNameLabel.text = MusicViewModel.shared.currentTrackName
        trackNameLabel.text = trackName

    }
    
    // MARK: OBJC METHODS =================================================================================================

    @objc
    private func nextTrackAction () {
        delegate?.nextTrack()
        setTrackName()
    }
    
    
    @objc
    private func previousTrackAction () {
        delegate?.previousTrack()
        setTrackName()
    }
    
    @objc
    private func playPauseButtonAction() {
        let iconName = MusicViewModel.shared.player.isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setCustomImage(name: iconName, size: 32)
        delegate?.playPause()
    }
    
    
    @objc
    private func stopButtonAction() {
        let iconName = MusicViewModel.shared.player.isPlaying ? "play.fill" : "pause.fill"
        playPauseButton.setCustomImage(name: iconName, size: 32)
        delegate?.stop()
    }
}

