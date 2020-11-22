//
//  ViewController.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var calendar: FacebookCalendar?
    let cellId:String = "eventCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchAllEvents()
    }
    
    //MARK: Setup
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchAllEvents() {
        calendar = FacebookCalendar.getCalendar()
        tableView.reloadData()
    }


}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let calendar = calendar else { return 0 }
        return calendar.eventsOccuringOn(date: calendar.dates[section]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? EventTableViewCell, let calendar = calendar else { return UITableViewCell() }
        let eventsOnDay = calendar.eventsOccuringOn(date: calendar.dates[indexPath.section])
        let event = eventsOnDay[indexPath.row]
        let conflictingEvents = calendar.conflictingEvents()
        cell.updateWith(event: event, conflicting: conflictingEvents.contains(event))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return calendar?.dates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return calendar?.dates[section].dateHeader() ?? ""
    }
    
    
}

