//
//  SessionOverviewCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 2.01.2022.
//

import Foundation
import UIKit

class SessionOverviewCell: UITableViewCell {
    
    @IBOutlet weak var numberOfLapsLabel: UILabel!
    @IBOutlet weak var avgTimeLapLabel: UILabel!
    @IBOutlet weak var avgSpeedLabel: UILabel!
    
    @IBOutlet weak var peakSpeedLabel: UILabel!
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
    
    func initViews(lapCount: Int, distance: Double?, minutes: Double?, avgTimeLap: Double?,avgSpeed: Double?, peakSpeed: Double?) {
        
        numberOfLapsLabel.text = String(lapCount)
        avgSpeedLabel.text = String(avgSpeed ?? 0.0)
        
        avgTimeLapLabel.text = String(avgTimeLap ?? 0.0)
        avgSpeedLabel.text = String(avgSpeed ?? 0.0)
        peakSpeedLabel.text = String(peakSpeed ?? 0.0)
        
    }
    
}
