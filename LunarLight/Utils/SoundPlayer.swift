//
//  SoundPlayer.swift
//  LunarLight
//
//  Created by Daniel Falkedal on 2022-04-07.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    static var audioPlayer: AVAudioPlayer?
    
    static let SFX_EXTENSION = "wav"
    
    static let NEW_MSG_SFX = "new_message"

    static func playSound(sound: String) {
        
        if let path = Bundle.main.path(forResource: sound, ofType: SoundPlayer.SFX_EXTENSION) {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()

            } catch {
                print("Error: Could not play sound effect")
            }
        }
    }

    
}
