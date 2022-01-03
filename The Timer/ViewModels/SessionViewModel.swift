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
                        playerLapDetails.lapTimeInSeconds = lapTimeInSeconds
                        
                        let calculatedTotalLapTimesInSeconds = (playerSessionObject.totalLapTimesInSeconds ?? 0) + lapTimeInSeconds
                        playerSessionObject.laps.append(playerLapDetails)
                        
                        playerSessionObject.lapTimesArray.append(Double(lapTimeInSeconds))
                        playerSessionObject.totalLapTimesInSeconds = calculatedTotalLapTimesInSeconds
                        realm.add(playerPracticeObject, update: .modified)
                        
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
    
//    save players practice details based on spesific session
    func saveSessionOverview(playerId: String, sessionId: String, lapCount: Int, finalTimeInSeconds: Int, distance: Double) {
        DispatchQueue.main.async {
            let realm = try! Realm()

            if let playerPracticeObject = realm.objects(PlayerPractices.self).first(where: { practice in
                practice.playerId == playerId
            }){
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
                        
                        let sessionOverview = CompletedSessionOverview()
                        sessionOverview.lapCount = lapCount
                        sessionOverview.peakSpeed = peakSpeedInSeconds
                        sessionOverview.finalTimeInSeconds = finalTimeInSeconds
                        sessionOverview.avgSpeedInMS = averageSpeedInMS
                        sessionOverview.avgTimeLap = avgTimeLap
                        
                        playerSessionObject.completedSessionOverview = sessionOverview
                        
                        realm.add(playerPracticeObject, update: .modified)
                        
                        self.playerPracticesModel = playerPracticeObject
                    }


            }
                
            }

    }

    }
    
}


