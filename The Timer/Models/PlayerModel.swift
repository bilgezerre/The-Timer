//
//  PlayerModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 22.12.2021.
//

import Foundation
import RealmSwift


class Players: Object, Decodable {

     @Persisted var results: List<Player>

    private enum CodingKeys: String, CodingKey {
        case results
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let players = try values.decode([Player].self, forKey: .results)
        self.results.append(objectsIn: players)
       
    }
    
}

class Player: Object, Decodable {
    
     @Persisted(primaryKey: true) var id: ObjectId
     @Persisted var name: Name?
     @Persisted var picture: Picture?
     @Persisted var playerPractices: PlayerPractices?

    
    private enum CodingKeys: String, CodingKey {
        case name
        case picture
        case playerPractices
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        self.name = name
        self.picture = picture
        self.playerPractices = playerPractices
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(Name.self, forKey: .name)
        picture = try container.decode(Picture.self, forKey: .picture)
        
    }
}

class Name: EmbeddedObject, Decodable {
    
     @Persisted var title: String?
     @Persisted var first: String?
     @Persisted var last: String?

    private enum CodingKeys: String, CodingKey {
        case title
        case first
        case last
    }
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        first = try container.decode(String.self, forKey: .first)
        last = try container.decode(String.self, forKey: .last)
    }
}

class Picture: EmbeddedObject, Decodable {
    
     @Persisted var large: String?
     @Persisted var medium: String?
     @Persisted var thumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case large
        case medium
        case thumbnail
    }

    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)

        large = try container.decode(String.self, forKey: .large)
        medium = try container.decode(String.self, forKey: .medium)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }

}


