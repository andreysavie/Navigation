//
//  VideoViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 11.06.2022.
//

import UIKit
import AVKit
import youtube_ios_player_helper


final class VideoViewModel {
        
    
//    private lazy var streamURL = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8")!
    private lazy var streamURL = URL(string: "https://www.youtube.com/watch?v=KfLxG2AdfXw")!



    private lazy var localURL: URL = {
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")!
        return URL(fileURLWithPath: path)
    }()

    func playButtonPressed(navController: UINavigationController) {
        // Создаём AVPlayer со ссылкой на видео.
        let player = AVPlayer(url: streamURL)

        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player

        // Показываем контроллер модально и запускаем плеер.
        navController.present(controller, animated: true) {
            player.play()
        }
    }

}

