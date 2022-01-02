//
//  LapTimesTableViewCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 27.12.2021.
//

import Foundation
import UIKit

class LapTimesTableViewCell: UITableViewCell {
    @IBOutlet weak var lapsTitleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    func initViews(lapDetails: PlayerLap?) {
        lapsTitleLabel.text = "Laps"
        if let playerLap = lapDetails {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            let lapInfoText = "\(playerLap.lapNumber ?? 0))    \(playerLap.time ?? "")"
            label.text = lapInfoText
            stackView.addArrangedSubview(label)            
        }
    }
}
