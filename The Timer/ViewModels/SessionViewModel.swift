//
//  SessionViewModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import Foundation
import RealmSwift


class SessionViewModel {
    
    var reloadTableViewClosure: (() -> Void)?
    
    var playerSessionModel: PlayerSession? = PlayerSession() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    var playerLapModel: [PlayerLap]? = [PlayerLap]() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    
//    store the lap of the player's session - if it is the first lap store create the new object otherwise update the object with new added laps
    func storePlayersLap(playerId: String, timeString: String, lapCount: Int) {
        
        DispatchQueue.main.async {
                autoreleasepool {

                    let realm = try! Realm()
                    var playerLapData = List<PlayerLap>()
                    let playerSession = realm.objects(PlayerSession.self)
                    if lapCount != 1 {
                        if let playerSessionObject = playerSession.first(where: { session in
                            session.playerId == playerId
                        }){
                            playerLapData = playerSessionObject.laps
                            try! realm.write {
                                let playerLapDetails = PlayerLap()
                                playerLapDetails.lapNumber = lapCount
                                playerLapDetails.time = timeString
                                
                                playerLapData.append(playerLapDetails)

                                print("lapDetails\(playerLapDetails)")
                                
                                playerSessionObject.laps = playerLapData
                                
                                self.playerSessionModel = playerSessionObject
                            }
                        }
                    } else {
                        try! realm.write {
                            let playerLapDetails = [PlayerLap]()
                            playerLapDetails.first?.lapNumber = lapCount
                            playerLapDetails.first?.time = timeString
                            
                            
                            let playerSession = PlayerSession(playerId: playerId, laps: playerLapDetails)
                            realm.add(playerSession)
                            self.playerSessionModel = playerSession
                        }
                    }
                    
            }
        }
        
    }
}


