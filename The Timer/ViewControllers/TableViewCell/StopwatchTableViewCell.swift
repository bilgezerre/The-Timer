//
//  StopwatchTableViewCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 27.12.2021.
//

import UIKit

class StopwatchTableViewCell: UITableViewCell {
    @IBOutlet weak var counterLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initView(isTimerWorking: Bool, timeString: String?){
        counterLabel.isHidden = !(isTimerWorking)
        if isTimerWorking && timeString != "" {
            counterLabel.text = timeString
        } else {
            counterLabel.text = "00 : 00 : 00"
        }
    }
}
