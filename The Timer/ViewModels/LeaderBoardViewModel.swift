//
//  LeaderBoardViewModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import Foundation
import RealmSwift
import SwiftUI

class LeaderBoardViewModel {
    
    var reloadTableViewClosure: (() -> Void)?
    
    var players: [Player]? = [Player]() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }

    
//    get players' required information based on selected filter
    func getLeaderBoardPlayerInfo(filter: Filter){
        DispatchQueue.main.async {
                autoreleasepool {
                    let realm = try! Realm()
                    let players = realm.objects(Players.self).first?.results.toArray()
                    switch filter {
                    case .explosiveness:
                        let sortedPlayersAsExplosiveness = players?.sorted(by: {$0.playerPractices?.peakSpeedForSession ?? 0 > $1.playerPractices?.peakSpeedForSession ?? 0})
                        self.players = sortedPlayersAsExplosiveness
                    case .endurance:
                        let sortedPlayersAsEndurance = players?.sorted(by: {$0.playerPractices?.maxLapNumber ?? 0 > $1.playerPractices?.maxLapNumber ?? 0})
                        self.players = sortedPlayersAsEndurance
                    case .none:
                        self.players = players
                    }
                }
            }
    }
    
    
}
