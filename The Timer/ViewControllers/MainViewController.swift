//
//  MainViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 22.12.2021.
//

import UIKit
import RealmSwift

//MainViewController: Displays the players information inside tableview
class MainViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var playersViewModel = PlayersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        playersViewModel.storePlayers()
        initViewModel()
    }
    
    func initViews(){
        self.setHeaderOnlyTitle(title: "PLAYERS")
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
//    initViewModel to retrieve players information
    func initViewModel(){
        playersViewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Delegate & Datasource
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersViewModel.getPlayersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as? PlayerTableViewCell {
            let player = playersViewModel.playerModel?[indexPath.row]
            cell.initView(player: player)
            return cell
        }
            return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Globals.shared.screenWidth * 0.2
    }
    
//    Navigate the user to input view controller for the selected user
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        vc.playerId = playersViewModel.playerModel?[indexPath.row].id.stringValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
