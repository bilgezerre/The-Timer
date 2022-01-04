//
//  PlayersViewModel.swift
//  The Timer
//
//  Created by Bilge Zerre on 22.12.2021.
//

import Foundation
import RealmSwift


class PlayersViewModel {

    
    var reloadTableViewClosure: (() -> Void)?
    
    var playerModel: [Player]? = [Player]() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    var selectedPlayerModel: Player? = Player() {
        didSet{
            self.reloadTableViewClosure?()
        }
    }
    
    
    func getPlayerInfo(playerId: String) {
    
        DispatchQueue.main.async {
                autoreleasepool {
                    let realm = try! Realm()

                    let playersData = realm.objects(Players.self)
                    self.playerModel = playersData.first?.results.toArray()
                    let singlePlayer = self.playerModel?.first(where: { player in
                        player.id.stringValue == playerId
                    })
                    self.selectedPlayerModel = singlePlayer
                    
                }
            }
    
    }
    
    
    func getPlayersCount() -> Int {
        return playerModel?.count ?? 0
    }
    
//    store players info by retrieving from the given API
    func storePlayers() {
        if let url = URL(string: "https://randomuser.me/api/?seed=empatica&inc=name,picture&gender=male&results=10&noinfo") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let playerData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(Players.self, from: playerData)
                        DispatchQueue.main.async {
                                autoreleasepool {
                                    let realm = try! Realm()
                                    try! realm.write {
                                        let players = decodedData
                                        realm.add(players)
                                        print(players)
                                    }
                                    let playersData = realm.objects(Players.self)
                                    self.playerModel = playersData.first?.results.toArray()
                                }
                            }

                        print(decodedData.results)
                    } catch  {
                        print(error)
                    }
                }
            }.resume()

        }
    }
    
}


