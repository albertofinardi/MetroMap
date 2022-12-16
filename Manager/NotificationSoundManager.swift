//
//  NotificationSoundManager.swift
//  MetroMap
//
//  Created by Alberto Finardi on 16/12/22.
//

import Foundation

class NotificationSoundManager {
    func getSound() -> String {
        let sounds : [String] = [
            "fart_reverb",
            "wow",
            "bruh",
            "scream",
            "right_back",
            "lying"
        ]
        
        return "\(sounds.randomElement()!).mp3"
    }
}
