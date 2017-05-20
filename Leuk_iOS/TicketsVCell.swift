//
//  EventsVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class TicketsVCell : UICollectionViewCell {
	
	
	@IBOutlet weak var placeImage: UIImageView!
	@IBOutlet weak var orderDate: UILabel!
	@IBOutlet weak var orderTime: UILabel!
	
	
	@IBOutlet weak var EventName: UILabel!
	@IBOutlet weak var organiserCommitee: UILabel!
	@IBOutlet weak var totalCharge: UILabel!
	@IBOutlet weak var quantity: UILabel!
	
	
	
	
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let view = UIView(frame: frame)
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.black.cgColor
	}
    
}
