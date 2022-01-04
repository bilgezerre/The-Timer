//
//  SessionToLeaderBoardNavigationCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import UIKit

class SessionToLeaderBoardNavigationCell: UITableViewCell{
    
    @IBOutlet weak var navigationButton: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    update button ui and navigate leader board vc from the navigation button
    func initViews(){
        navigationButton.cornerRadius = 10
        navigationButton.tap {
            if let parent = self.parentViewController {
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = storyboard.instantiateViewController(withIdentifier: "LeaderBoardViewController") as! LeaderBoardViewController
                parent.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
