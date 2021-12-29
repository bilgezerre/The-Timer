//
//  SessionViewController.swift
//  The Timer
//
//  Created by Bilge Zerre on 26.12.2021.
//

import UIKit
import RealmSwift

protocol SessionDelegate: AnyObject {
    func startButtonPressed()
    func lapButtonPressed()
    func finishButtonPressed()
}

struct SessionComponents {
    var type: SessionComponentType
}
enum SessionComponentType {
    case playerDetails
    case stopwatch
    case lapFinish
    case lapDetails
    case sessionOverview
}

class SessionViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerId: String = ""
    var distance: Double? = 0
    var lapCount = 0
    var timer = Timer()
    var counter = 0
    var isTimerWorking: Bool = true
    var isPlaying = false
    var timeString: String = ""
    var sessionViewModel = SessionViewModel()
    var playersViewModel = PlayersViewModel()
    var playerLapDetails = List<PlayerLap>()
    var sessionComponents: [SessionComponents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initViewModel()
        playersViewModel.getPlayerInfo(playerId: self.playerId)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
    func initViews() {
        setHeaderView()
        setComponents()
        setTimer()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
//    create timer to start stopwatch
    func setTimer() {
        isTimerWorking = true
        Notification.success(title: "", text: "The session has been started")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
//    update counter convert time string and reload only stopwatch cell each second to show the update
    @objc func updateCounter() {
        counter = counter + 1
        let time = secondsToHoursMinutesSeconds(seconds: counter)
        self.timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        reloadStopwatchCell()
    }
    
//    only reload the cell which includes the stopwatch
    func reloadStopwatchCell(){
        if self.sessionComponents[1].type == .stopwatch {
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                self.setHeaderView()
            }
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
//    stop the timer, initilizate time string to beginning
    func stopTimer()  {
        counter = 0
        timer.invalidate()
        timeString = makeTimeString(hours: 0, minutes: 0, seconds: 0)
        isTimerWorking = false
        Notification.success(title: "", text: "The session has been stopped")
    }
    
    func setHeaderView() {
        let headerViewRect = CGRect(x: 0, y: 0, width: Globals.shared.screenWidth, height: Globals.shared.screenWidth * 0.4830917874)
        let headerView = SessionHeaderCell(frame: headerViewRect)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.frame = headerViewRect
        headerView.initView(imageName: "sessionHeaderImage")
    }
    
//    initviewmodel to the take live data from player and session model
    func initViewModel() {
        sessionViewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
                self.setHeaderView()
                self.setComponents()
                self.tableView.reloadData()
            
        }
        
        playersViewModel.reloadTableViewClosure = { [weak self] in
            guard let self = self else { return }
                self.setHeaderView()
                self.setComponents()
                self.tableView.reloadData()
            
        }
    }
    
//    add sections to an array to create section based structure in tableview
    func setComponents() {
        self.sessionComponents.removeAll()
        self.sessionComponents.append(contentsOf: [
            SessionComponents(type: .playerDetails),
            SessionComponents(type: .stopwatch),
            SessionComponents(type: .lapFinish),
            SessionComponents(type: .lapDetails),
            SessionComponents(type: .sessionOverview),
        ])
        
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i.%02i", hours, minutes, seconds)
    }
    
}

extension SessionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sessionComponents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let component = sessionComponents[indexPath.section]
        switch component.type {
        case .playerDetails:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            cell.initView(player: playersViewModel.selectedPlayerModel)
            return cell
        case .stopwatch:
            let cell = tableView.dequeueReusableCell(withIdentifier: "StopwatchTableViewCell", for: indexPath) as! StopwatchTableViewCell
            cell.initView(isTimerWorking: isTimerWorking, timeString: self.timeString)
            return cell
        case .lapFinish:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionLapFinishCell", for: indexPath) as! SessionLapFinishCell
            cell.delegate = self
            cell.initView(isTimerWorking: isTimerWorking, timeString: self.timeString)
            return cell
        case .lapDetails:
            if let playerLapDetails = sessionViewModel.playerLapModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LapTimesTableViewCell", for: indexPath) as! LapTimesTableViewCell
                cell.initViews(lapDetails: playerLapDetails)
                return cell
            }
            return UITableViewCell()
            
        case .sessionOverview:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let component = sessionComponents[indexPath.section]
        switch component.type {
        case .playerDetails:
            return Globals.shared.screenWidth * 0.2
        case .stopwatch:
            return Globals.shared.screenWidth * 0.2
        case .lapFinish:
            return Globals.shared.screenWidth * 0.6280193237
        case .lapDetails:
            let playerLapDetails = sessionViewModel.playerLapModel
            if playerLapDetails?.count ?? 0 > 0 {
                return CGFloat.leastNormalMagnitude
            }
            return 0
        case .sessionOverview:
            return Globals.shared.screenWidth * 0.4830917874
        }
    }
    
}

extension SessionViewController: SessionDelegate {
    
//    starts the timer
    func startButtonPressed() {
        setTimer()
        tableView.reloadData()
    }
    
//    send data to view model to update the db based on laps in session
    func lapButtonPressed() {
        self.lapCount += 1
        sessionViewModel.storePlayersLap(playerId: self.playerId, timeString: self.timeString, lapCount: self.lapCount)
    }
    
//    stop the timer
    func finishButtonPressed() {
        self.stopTimer()
        tableView.reloadData()
            
    }
    
}


