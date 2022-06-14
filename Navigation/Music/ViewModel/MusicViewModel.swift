//
//  MusicViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import AVFoundation


final class MusicViewModel: PlayerDelegate {
    
    var playerView: MusicPlayerView?
    
    var tracks: [String: String] = [
        "Adieu" : "Rammstein",
        "Angst" : "Rammstein",
        "Armee Der Tristen" : "Rammstein",
        "Dicke Titten" : "Rammstein",
        "Zeit" : "Rammstein"
    ]
    
    static var shared = MusicViewModel()
    
    var player = AVAudioPlayer()
    private var counter = 0
    
    public var currentTrackName: String {
        get {
            let singer = Array(tracks.values)[counter]
            let track = Array(tracks.keys)[counter]
            return "\(singer) - \(track)"
        }
    }
    
    init() {
        
        if let playerView = playerView {
            playerView.delegate = self
        }
        
        setTrack()
    }
    
    func getTrackName (index: Int) -> String {
        return "\(Array(tracks.values)[index]) - \(Array(tracks.keys)[index])"
    }

    
    func playPause() {
        
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func stop() {
        player.stop()
        player.currentTime = 0
    }
    
    func nextTrack() {
        if counter == tracks.count - 1 {
            counter = 0
        } else {
            counter += 1
        }
        setTrack()
        player.play()
    }
    
    func previousTrack() {
        if counter == 0 {
            counter = tracks.count - 1
        } else {
            counter -= 1
        }
        setTrack()
        player.play()
    }
    
    
    func setTrack() {
        let trackName = Array(tracks.keys)[counter]
        
        guard let trackURL = Bundle.main.url(forResource: trackName, withExtension: "mp3") else { return }
        
        do {
            try player = AVAudioPlayer(contentsOf: trackURL)
            player.prepareToPlay()
            
        } catch { print(error.localizedDescription) }
    }
    
    func playSelectedTrack (forIndex index: Int) {
        counter = index
        setTrack()
        player.play()
    }
    
    
}
