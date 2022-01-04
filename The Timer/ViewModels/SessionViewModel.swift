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
    func storePlayersLap(playerPractices: PlayerPractices, sessionId: String, timeString: String, lapCount: Int, lapTimeInSeconds: Int) {
            DispatchQueue.main.async {
                let realm = try! Realm()

                if let player = realm.objects(Players.self).first?.results.first(where: { player in
                    player.id.stringValue == playerPractices.playerId
                }){
                    
                    if let playerPracticeObject = player.playerPractices {
                        if let playerSessionObject = playerPracticeObject.playerSession.first(where: { session in
                            session.sessionId.stringValue == sessionId
                        }) {
                            try! realm.write {
                                let playerLapDetails = PlayerLap()
                                playerLapDetails.lapNumber = lapCount
                                playerLapDetails.time = timeString
                                playerLapDetails.lapTimeInSeconds = lapTimeInSeconds
                                
                                let calculatedTotalLapTimesInSeconds = (playerSessionObject.totalLapTimesInSeconds ?? 0) + lapTimeInSeconds
                                playerSessionObject.laps.append(playerLapDetails)
                                
                                playerSessionObject.lapTimesArray.append(Double(lapTimeInSeconds))
                                playerSessionObject.totalLapTimesInSeconds = calculatedTotalLapTimesInSeconds
                                

                                realm.add(player, update: .modified)
                                
                                self.playerPracticesModel = playerPractices
                            }
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
                        if let player = realm.objects(Players.self).first?.results.first(where: { player in
                            player.id.stringValue == playerId
                        }) {
                            if  player.playerPractices == nil  {
                                let playerPractices = PlayerPractices()
                                playerPractices.playerId = playerId
                                playerPractices.peakSpeedForSession = 0.0
                                playerPractices.maxLapNumber = 0
                                let playerSession = PlayerSession()
                                
                                
                                playerPractices.playerSession.append(playerSession)
                                player.playerPractices = playerPractices
                                
                                self.playerPracticesModel = playerPractices
                                self.playersOngoingSession = playerSession
                            } else {
                                if let newPlayerPractice = player.playerPractices {
                                    let playerSession = PlayerSession()
                                    newPlayerPractice.playerSession.append(playerSession)
                                    player.playerPractices = newPlayerPractice
                                    
                                    realm.add(player, update: .modified)
                                    
                                    self.playerPracticesModel = player.playerPractices
                                    self.playersOngoingSession = playerSession
                                }
                            }
                        }
                        
                    }
                }
        }
    }
    
//    save players practice details based on spesific session
    func saveSessionOverview(playerId: String, sessionId: String, lapCount: Int, finalTimeInSeconds: Int, distance: Double) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            
            
            if let player = realm.objects(Players.self).first?.results.first(where: { player in
                player.id.stringValue == playerId
            }) {
                if let playerPracticeObject = player.playerPractices {
                    if let playerSessionObject = playerPracticeObject.playerSession.first(where: { session in
                    session.sessionId.stringValue == sessionId
                }) {
                        try! realm.write {
                            let playerLapArray = playerSessionObject.laps.toArray()
                            let playerLapWithMinLapTime = playerLapArray.min { lap1, lap2 in
                                lap1.lapTimeInSeconds ?? 0 < lap2.lapTimeInSeconds ?? 0
                            }
                            let peakSpeedInSeconds = Double(playerLapWithMinLapTime?.lapTimeInSeconds ?? 0)/60.0
                            
                            let averageSpeedInMS = distance / Double(finalTimeInSeconds)
                            
                            let avgTimeLap = Double(playerSessionObject.totalLapTimesInSeconds ?? 1) / Double(lapCount)
                            
                            let sessionOverview = CompletedSessionOverview(lapCount: lapCount, finalTimeInSeconds: finalTimeInSeconds, peakSpeed: peakSpeedInSeconds, avgSpeedInMS: averageSpeedInMS, avgTimeLap: avgTimeLap)
                            
                            if (playerPracticeObject.maxLapNumber ?? 0 < lapCount) {
                                playerPracticeObject.maxLapNumber = lapCount
                            }
                            
                            if (playerPracticeObject.peakSpeedForSession ?? 0.0 < peakSpeedInSeconds) {
                                playerPracticeObject.peakSpeedForSession = peakSpeedInSeconds
                            }
                            
                            playerSessionObject.completedSessionOverview = sessionOverview
                            
                            realm.add(player, update: .modified)
                            
                            self.playerPracticesModel = playerPracticeObject
                        }

                    }
                }
                
            }

        }

    }
}


