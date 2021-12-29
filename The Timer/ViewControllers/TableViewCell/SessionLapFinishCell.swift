//
//  SessionLapFinishCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import UIKit

class SessionLapFinishCell: UITableViewCell {
    
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    weak var delegate: SessionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        let view = loadNib()
        view.frame = self.bounds
        addSubview(view)
        selectionStyle = .none
    }
    
// Includes the ui and the functionality when start,lap and finish button pressed by using delegates.
    func initView(isTimerWorking: Bool,timeString: String?) {
        startButton.cornerRadius = 5
        finishButton.cornerRadius = 5
        lapButton.cornerRadius = 5
        lapButton.isEnabled = isTimerWorking
        startButton.backgroundColor = isTimerWorking ? .lightGray : .darkGray
        
        startButton.tap {
            if !(isTimerWorking) {
                self.startButton.backgroundColor = .lightGray
                self.lapButton.isEnabled = true
                self.delegate?.startButtonPressed()
            } else {
                Notification.error(title: "Ongoing session", text: "Finish the ongoing session to start a new session.")
            }
        }
        
        lapButton.tap {
            if isTimerWorking {
                self.delegate?.lapButtonPressed()
                Notification.warning(title: "", text: "New Lap!")
            }
            
        }
        finishButton.tap {
            if isTimerWorking {
                self.startButton.backgroundColor = .darkGray
                self.lapButton.isEnabled = false
                self.delegate?.finishButtonPressed()
            } else {
                Notification.error(title: "No session", text: "Start the session to finish it.")
            }

        }
        
    }
}
