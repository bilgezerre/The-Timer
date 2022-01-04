//
//  LeaderBoardViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 3.01.2022.
//

import Foundation
import UIKit
import FittedSheets

enum Filter {
    case explosiveness
    case endurance
    case none
}

class LeaderBoardViewController: BaseViewController {
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    public var selected: Int = 0

    var leaderBoardViewModel = LeaderBoardViewModel()
    var filterSelection: Filter = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initViewModel()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initViews(){
        filterSelection = .none
        leaderBoardViewModel.getLeaderBoardPlayerInfo(filter: filterSelection)
        selectButton.cornerRadius = 10
        selectButton.tap {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier: "PickerViewController") as! PickerViewController
            vc.pickerDataArray = ["Explosiveness","Endurance","None"]
            vc.filterSelection = self.filterSelection
            vc.returnForUpdate = {(filterSelection) in
                self.filterSelection = filterSelection
                self.update(filterSelection: filterSelection)
            }
            let options = SheetOptions(pullBarHeight: 0, shouldExtendBackground: false)
            let sheet = SheetViewController(controller: vc, sizes: [.percent(0.35)], options: options)
            let color = UIColor.clear.withAlphaComponent(0.5)
            sheet.overlayColor = color
            sheet.allowPullingPastMaxHeight = false
            sheet.allowPullingPastMinHeight = false
            sheet.cornerRadius = 0
            self.present(sheet, animated: true, completion: nil)
        }
    }
    
    func update(filterSelection: Filter){
        leaderBoardViewModel.getLeaderBoardPlayerInfo(filter: filterSelection)
    }

    func initViewModel(){
        leaderBoardViewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView Delegate & Datasource
extension LeaderBoardViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderBoardViewModel.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as? LeaderBoardCell {
            let player = leaderBoardViewModel.players?[indexPath.row]
            cell.initView(player: player, filterSelection: filterSelection)
            return cell
        }
            return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Globals.shared.screenWidth * 0.2
    }

    
}
