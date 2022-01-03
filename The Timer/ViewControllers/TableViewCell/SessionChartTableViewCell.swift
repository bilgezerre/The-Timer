//
//  SessionChartTableViewCell.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import UIKit
import Charts

class SessionChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initViews(data: LineChartData){
        lineChartView.data = data
    }
}
