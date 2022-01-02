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
    

    private enum CodingKeys: String, CodingKey {
        case sessionId
        case laps
    }
  
    convenience init(laps: [PlayerLap]) {
        self.init()
        self.laps.append(objectsIn: laps)
    }
}

class PlayerLap: EmbeddedObject, Decodable {
    
    @Persisted var lapNumber: Int?
    @Persisted var time: String?

}
