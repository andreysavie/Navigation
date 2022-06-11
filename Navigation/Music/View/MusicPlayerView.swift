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
    
    private var player = AVAudioPlayer()
    
    private var model = MusicViewModel()

    private var counter = 0
    
    private var currentTrackName: String {
        get {
            let singer = Array(model.tracks.values)[counter]
            let track = Array(model.tracks.keys)[counter]
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

    
    init () {
        super.init(frame: .zero)
        
        addSubviews(playerButtonsStackView, trackNameLabel)
        backgroundColor = .blue
        setuplayout()
        setTrack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTrack() {
        let trackName = Array(model.tracks.keys)[counter]

        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: trackURL)
            player.prepareToPlay()

        } catch {
            print(error.localizedDescription)
        }
        
        trackNameLabel.text = currentTrackName
    }

    public func playSelectedTrack (forIndex index: Int) {
        counter = index
        setTrack()
        player.play()
    }
    
    @objc func nextTrackAction () {
        if counter == model.tracks.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    
    @objc func prevTrackAction () {
        if counter == 0 {
            counter = model.tracks.count - 1
        } else {
            counter -= 1
        }
        trackNameLabel.text = "\(currentTrackName)"
        setTrack()
        player.play()
    }
    
    @objc
    func playPauseButtonAction() {
        
        if player.isPlaying {
            player.pause()
            playPauseButton.setCustomImage(name: "play.fill", size: 32)
            
        } else {
            player.play()
            playPauseButton.setCustomImage(name: "pause.fill", size: 32)
        }
    }
    
    
    @objc
    func stopButtonAction() {
        player.stop()
        player.currentTime = 0
        playPauseButton.setCustomImage(name: "play.fill", size: 32)
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
}

public extension UIButton {
    
    func setCustomImage (name: String, size: CGFloat) {
        setImage((UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(pointSize: size))?.withTintColor(.black, renderingMode: .alwaysOriginal))!, for: .normal)
    }
}

public extension UIView {
    
    func getButton (icon name: String, action: Selector ) -> UIButton {
        let button = UIButton()
        button.setCustomImage(name: name, size: 32)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
}
