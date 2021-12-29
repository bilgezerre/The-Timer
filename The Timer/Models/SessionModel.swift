//
//  SessionModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import Foundation
import RealmSwift


class PlayerSession: Object, Decodable {
    
    @Persisted(primaryKey: true) var sessionId: ObjectId
    @Persisted var playerId: String?
    @Persisted var laps: List<PlayerLap>
    

    private enum CodingKeys: String, CodingKey {
        case playerId
        case sessionId
        case laps
    }
  
    convenience init(playerId: String, laps: [PlayerLap]) {
        self.init()
        self.playerId = playerId
        self.laps.append(objectsIn: laps)
        
    }

}

class PlayerLap: EmbeddedObject, Decodable {
    
    @Persisted var lapId: ObjectId
    @Persisted var lapNumber: Int?
    @Persisted var time: String?

}
