//
//  MusicPlayerView.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import AVFoundation
import SnapKit

class MusicPlayerView: UIView {
    
    // MARK: PROPERTIES =============================================================================================
    
    private var player = AVAudioPlayer()
    private var model = MusicViewModel()
    private var counter = 0
    
    private var currentTrackName: String {
        get {
            let singer = Array(MusicViewModel.tracks.values)[counter]
            let track = Array(MusicViewModel.tracks.keys)[counter]
            return "\(singer) - \(track)"
        }
    }
    
    private lazy var playPauseButton = getButton(icon: "play.fill", action: #selector(playPauseButtonAction))
    private lazy var stopButton = getButton(icon: "stop.fill", action: #selector(stopButtonAction))
    private lazy var nextTrackButton = getButton(icon: "forward.fill", action: #selector(nextTrackAction))
    private lazy var previousTrackButton = getButton(icon: "backward.fill", action: #selector(prevTrackAction))
    
    private lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var playerButtonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousTrackButton, playPauseButton, stopButton, nextTrackButton])
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
        setTrack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: METHODS =================================================================================================
    
    private func setTrack() {
        let trackName = Array(MusicViewModel.tracks.keys)[counter]
        
        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: trackURL)
            player.prepareToPlay()
            
        } catch { print(error.localizedDescription) }
        
        trackNameLabel.text = currentTrackName
    }
    
    
    public func playSelectedTrack (forIndex index: Int) {
        counter = index
        setTrack()
        player.play()
        playPauseButton.setCustomImage(name: "pause.fill", size: 32)
    }
    
    private func setuplayout() {
        
        playerButtonsStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(32)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.bottom.equalTo(playerButtonsStackView.snp.top).offset(-32)
        }
    }
    
    
    // MARK: OBJC METHODS =================================================================================================

    @objc
    private func nextTrackAction () {
        if counter == MusicViewModel.tracks.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    
    @objc
    private func prevTrackAction () {
        if counter == 0 {
            counter = MusicViewModel.tracks.count - 1
        } else {
            counter -= 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    @objc
    private func playPauseButtonAction() {
        
        if player.isPlaying {
            player.pause()
            playPauseButton.setCustomImage(name: "play.fill", size: 32)
            
        } else {
            player.play()
            playPauseButton.setCustomImage(name: "pause.fill", size: 32)
        }
    }
    
    
    @objc
    private func stopButtonAction() {
        player.stop()
        player.currentTime = 0
        playPauseButton.setCustomImage(name: "play.fill", size: 32)
    }
}

