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
  
    var playerPracticesModel: PlayerPractices? = PlayerPractices() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    var playersOngoingSession: PlayerSession? = PlayerSession() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }

    
//    store the lap of the player's ongoing session
    func storePlayersLap(playerPractices: PlayerPractices, sessionId: String, timeString: String, lapCount: Int) {
            DispatchQueue.main.async {
                let realm = try! Realm()

                if let playerPracticeObject = realm.objects(PlayerPractices.self).first(where: { practice in
                    practice.playerId == playerPractices.playerId
                }){
                    if let playerSessionObject = playerPracticeObject.playerSession.first(where: { session in
                    session.sessionId.stringValue == sessionId
                }) {
                    try! realm.write {
                        let playerLapDetails = PlayerLap()
                        playerLapDetails.lapNumber = lapCount
                        playerLapDetails.time = timeString
                        print("lapDetails\(playerLapDetails)")
                        
                        playerSessionObject.laps.append(playerLapDetails)
                        print("playerSessionObject\(playerSessionObject)")
                
                        print("playerPracticeObjectBefore\(playerPracticeObject)")
                        realm.add(playerPracticeObject, update: .modified)

                        print("playerPracticeObject\(playerPracticeObject)")
                        
//                        playerPracticeObject?.playerSession = pl
                        
                        self.playerPracticesModel = playerPractices
                    }
                }
                    
                }

        }
        
    }
    
//    create PlayerPractices object to start a new session
    func createPlayerPracticesToStartSession(playerId: String) {
        
        DispatchQueue.main.async {
                autoreleasepool {

                    let realm = try! Realm()
                    try! realm.write {
                        if let existingPlayerPractices = realm.objects(PlayerPractices.self).first(where: { practise in
                            practise.playerId == playerId
                        }) {

                            let playerSession = PlayerSession()
                            existingPlayerPractices.playerSession.append(playerSession)
                            realm.add(existingPlayerPractices, update: .modified)
                            
                            self.playerPracticesModel = existingPlayerPractices
                            self.playersOngoingSession = playerSession
                            
                        } else {
                            let playerPractices = PlayerPractices()
                            playerPractices.playerId = playerId
                            let playerSession = PlayerSession()
                            
                            playerPractices.playerSession.append(playerSession)
                            realm.add(playerPractices)
                            
                            self.playerPracticesModel = playerPractices
                            self.playersOngoingSession = playerSession
                        }
                        

                    }
                }
        }
    }
    
}


