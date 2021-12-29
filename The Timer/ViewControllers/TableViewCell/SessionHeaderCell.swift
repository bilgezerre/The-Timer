//
//  SessionHeaderCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import UIKit

class SessionHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UIImageView!
    
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
    
    func initView(imageName: String) {
        headerView.image = UIImage(imageLiteralResourceName: imageName)
    }
}
