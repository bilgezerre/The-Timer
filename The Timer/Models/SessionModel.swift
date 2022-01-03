//
//  SessionModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import Foundation
import RealmSwift


class PlayerPractices: Object, Decodable {
    
    @Persisted(primaryKey: true) var playerId: String?
    @Persisted var playerSession: List<PlayerSession>
    

    private enum CodingKeys: String, CodingKey {
        case playerId
        case playerSession
    }
  
    convenience init(playerId: String, playerSession: [PlayerSession]) {
        self.init()
        self.playerId = playerId
        self.playerSession.append(objectsIn: playerSession)
        
    }

}

class PlayerSession: Object, Decodable {
    
    @Persisted(primaryKey: true) var sessionId: ObjectId
    @Persisted var laps: List<PlayerLap>
    @Persisted var totalLapTimesInSeconds: Int?
    @Persisted var completedSessionOverview: CompletedSessionOverview?
    @Persisted var lapTimesArray = List<Double>()
    

    private enum CodingKeys: String, CodingKey {
        case sessionId
        case laps
        case totalLapTimesInSeconds
        case completedSessionOverview
        case lapTimesArray
    }
  
    convenience init(laps: [PlayerLap], completedSessionOverview: CompletedSessionOverview, totalLapTimesInSeconds: Int, lapTimesArray: List<Double>) {
        self.init()
        self.laps.append(objectsIn: laps)
        self.completedSessionOverview = completedSessionOverview
        self.totalLapTimesInSeconds = totalLapTimesInSeconds
        self.lapTimesArray = lapTimesArray
    }
}

class PlayerLap: EmbeddedObject, Decodable {
    
    @Persisted var lapNumber: Int?
    @Persisted var time: String?
    @Persisted var lapTimeInSeconds: Int?

}

class CompletedSessionOverview: EmbeddedObject, Decodable {
    @Persisted var lapCount: Int?
    @Persisted var finalTimeInSeconds: Int?
    @Persisted var peakSpeed: Double?
    @Persisted var avgSpeedInMS: Double?
    @Persisted var avgTimeLap: Double?
    
    private enum CodingKeys: String, CodingKey {
        case lapCount
        case finalTimeInSeconds
        case peakSpeed
        case avgSpeedInMS
        case avgTimeLap
    }
  
    convenience init(lapCount: Int, finalTimeInSeconds: Int, peakSpeed: Double, avgSpeedInMS: Double, avgTimeLap: Double) {
        self.init()
        self.lapCount = lapCount
        self.finalTimeInSeconds = finalTimeInSeconds
        self.peakSpeed = peakSpeed
        self.avgSpeedInMS = avgSpeedInMS
        self.avgTimeLap = avgTimeLap
    }
}
