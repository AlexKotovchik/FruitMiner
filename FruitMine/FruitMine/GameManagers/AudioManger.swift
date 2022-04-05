//
//  AudioManger.swift
//  FruitMine
//
//  Created by AlexKotov on 12.03.22.
//

import AVFoundation
import AVKit
import SpriteKit

public struct Music {
    public var filename: String
    public var type: String
}

class AudioManager {
    
    public var backgroundMusicPlayer: AVAudioPlayer?
    
    static let shared = AudioManager()
    
    func play(music: Music) {
        guard Options.shared.sound else { return }
        if let player = backgroundMusicPlayer, player.isPlaying == true {
            player.numberOfLoops = -1
            player.volume = 0.2
            return
        } else {
            guard let url = Bundle.main.url(forResource: music.filename, withExtension: music.type) else { return }
            backgroundMusicPlayer =  try? AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0.2
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        }
    }
    
    func pause() {
        backgroundMusicPlayer?.pause()
    }

}

