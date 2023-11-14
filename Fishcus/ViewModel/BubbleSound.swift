//
//  BubbleSound.swift
//  Fishcus
//
//  Created by Dimas Aristyo Rahadian on 14/11/23.
//

import Foundation
import AVFoundation

class BubbleSound {
    var bubbleAudio: AVAudioPlayer?
    
    func setupAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "bubbleSound", ofType: "wav") else {
            print("Video file not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            bubbleAudio = try AVAudioPlayer(contentsOf: url)
            bubbleAudio?.prepareToPlay()
        } catch {
            print("Error: Couldn't create audio player.")
        }
    }
    
    func playSound() {
        print("Attempting to play sound")
        bubbleAudio?.play()
    }
}
