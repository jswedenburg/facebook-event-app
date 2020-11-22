//
//  ViewController.swift
//  facebook_event_app
//
//  Created by jake on 11/19/20.
//

import UIKit

class EventListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var calendar: FacebookCalendar?
    
    let cellId:String = "eventCell"
    let rowHeight: CGFloat = 80
    let headerHeight: CGFloat = 50

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
        calendar = FacebookCalendarManager.getCalendar()
        tableView.reloadData()
    }


}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let calendar = calendar else { return 0 }
        return calendar.calendarDays[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? EventTableViewCell, let calendar = calendar else { return UITableViewCell() }
        let calendarDay = calendar.calendarDays[indexPath.section]
        let event = calendarDay.events[indexPath.row]
        let conflicting = calendarDay.conflictingEvents().contains(event)
        cell.updateWith(event: event, conflicting: conflicting, position: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return calendar?.calendarDays.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return calendar?.calendarDays[section].day.dateHeader() ?? ""
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.systemGray2

        let headerLabel = UILabel()
        headerLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        headerLabel.textColor = UIColor.white
        headerLabel.text = calendar?.calendarDays[section].day.dateHeader() ?? ""
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
            let verticalConstraint = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: headerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: headerLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: headerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10)
        
        headerView.addConstraints([verticalConstraint, leadingConstraint])

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    
}

