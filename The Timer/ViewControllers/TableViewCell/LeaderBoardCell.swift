//
//  LeaderBoardCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import UIKit

class LeaderBoardCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var lapLabel: UILabel!
    @IBOutlet weak var peakSpeedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let view = loadNib()
        view.frame = self.bounds
        addSubview(view)
        selectionStyle = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    display view based on selected filter - make only the selected filter's field bold
    func initView(player: Player?, filterSelection: Filter) {
        nameLabel.text = "\(player?.name?.first ?? "") \(player?.name?.last ?? "")"
        if let playerImageURL = URL(string: player?.picture?.medium ?? "") {
            playerImageView.load(url: playerImageURL)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let peakSpeedForSession =  numberFormatter.string(from: NSNumber(value: player?.playerPractices?.peakSpeedForSession ?? 0.0)) else { fatalError("Can not get number") }
    
        peakSpeedLabel.text = "Peak Speed: " + String(peakSpeedForSession)
        lapLabel.text = "Number of Laps: " + String(player?.playerPractices?.maxLapNumber ?? 0)
        
        if filterSelection == .explosiveness {
            peakSpeedLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            lapLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        } else if filterSelection == .endurance {
            lapLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            peakSpeedLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }
}
