//
//  EventTableViewCell.swift
//  facebook_event_app
//
//  Created by jake on 11/20/20.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelEventStartTime: UILabel!
    @IBOutlet weak var labelEventEndTime: UILabel!
    @IBOutlet weak var viewDividingLine: UIView!
    @IBOutlet weak var labelConflict: UILabel!
    
    let separatorColors = [UIColor.blue, UIColor.green, UIColor.purple, UIColor.yellow]
    
    func updateWith(event: Event, conflicting: Bool, position: Int) {
        labelEventName.text = event.title
        labelEventStartTime.text = event.startHour
        labelEventEndTime.text = event.endHour
        
        labelConflict.isHidden = !conflicting
        labelConflict.text = "Conflict with another event"
        
        let colorIndex = (position + 1) % 4
        viewDividingLine.backgroundColor = separatorColors[colorIndex]
        
    }

    

}
