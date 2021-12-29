//
//  PlayerTableViewCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 25.12.2021.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    
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
    
    func initView(player: Player?){
        titleLabel.text = player?.name?.title
        fullNameLabel.text = "\(player?.name?.first ?? "") \(player?.name?.last ?? "")"
        if let playerImageURL = URL(string: player?.picture?.medium ?? "") {
            playerImageView.load(url: playerImageURL)
        }
        
    }
    
}
