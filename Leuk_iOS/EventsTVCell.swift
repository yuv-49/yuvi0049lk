//
//  EventsTVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class EventsTVCell: UITableViewCell {


	
	@IBOutlet weak var imageLink: UIImageView!
	@IBOutlet weak var logo: UIImageView!
	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var hostedBy: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var time: UILabel!
	@IBOutlet weak var daysCount: UILabel!
	
	
	
	var eventId : String!
	var eventLogo : String!
	var eventName : String!
	var eventImageLink : String!
	var eventHostedBy : String!
	var eventDate : String!
	var eventTime : String!
	var eventDifference: String!
	var eventCategory: String!
	var eventTicketBasecode: String!

	
	
	
	
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	logo.layoutIfNeeded()
	logo.layer.cornerRadius = self.frame.height / 8.0
	logo.layer.masksToBounds = true

	
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
