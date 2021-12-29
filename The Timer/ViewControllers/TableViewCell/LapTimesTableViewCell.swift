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
    
    func initViews(lapDetails: [PlayerLap]) {
        lapsTitleLabel.text = "Laps"
        
        lapDetails.forEach { lapInfo in
            let label = UILabel()
            let lapInfoText = "\(lapInfo.lapNumber).    \(lapInfo.time)"
            label.text = lapInfoText
            stackView.addArrangedSubview(label)
        }
        
    }
}
