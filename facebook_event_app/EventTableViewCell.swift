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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateWith(event: Event, conflicting: Bool) {
        labelEventName.text = event.title
        labelEventStartTime.text = event.startHour
        labelEventEndTime.text = event.endHour
        if (conflicting) {
            viewDividingLine.backgroundColor = UIColor.red
        } else {
            viewDividingLine.backgroundColor = UIColor.blue
        }
    }

    

}
