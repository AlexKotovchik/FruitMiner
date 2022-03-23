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
        guard Options.shared.sound else {
            return
        }
        if let player = backgroundMusicPlayer, player.isPlaying == true {
            player.numberOfLoops = -1
            player.volume = 0.2
            return
        } else {
            backgroundMusicPlayer?.stop()
            guard let newPlayer = try? AVAudioPlayer(soundFile: music) else { return }
            newPlayer.numberOfLoops = -1
            newPlayer.prepareToPlay()
            newPlayer.play()
            newPlayer.volume = 0.2
            backgroundMusicPlayer = newPlayer
        }
    }

    func pause() {
        backgroundMusicPlayer?.pause()
    }
    
    func play(effect: AudioEffect, node: SKNode) {
        guard Options.shared.sound else {
            return
        }
        node.run(.play(effect: effect))
    }
}

extension AVAudioPlayer {
    
    public enum AudioPlayerError: Error {
        case fileNotFound
    }
    
    public convenience init(soundFile: Music) throws {
        guard let url = Bundle.main.url(forResource: soundFile.filename, withExtension: soundFile.type) else { throw AudioPlayerError.fileNotFound }
        try self.init(contentsOf: url)
    }
}

