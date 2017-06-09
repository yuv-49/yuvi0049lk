//
//  OrderVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class OrderVCell: UICollectionViewCell {
	
	
	
	@IBOutlet weak var viewToColor: UIView!
	@IBOutlet weak var placeImage: UIImageView!
	@IBOutlet weak var orderDate: UILabel!
	@IBOutlet weak var orderTime: UILabel!
	@IBOutlet weak var placeName: UILabel!
	@IBOutlet weak var items: UILabel!
	@IBOutlet weak var totalCost: UILabel!
	@IBOutlet weak var orderStatus: UILabel!
	
	
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let view = UIView(frame: frame)
		view.layer.borderWidth = 2
		view.layer.borderColor = UIColor.black.cgColor
	}
	
	
}
