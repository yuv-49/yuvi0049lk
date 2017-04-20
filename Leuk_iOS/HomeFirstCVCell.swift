//
//  HomeFirstCVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class HomeFirstCVCell: UICollectionViewCell {
	
	
	@IBOutlet weak var firstImage: UIImageView!
	
	@IBOutlet weak var firstLabel: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let view = UIView(frame: frame)
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.black.cgColor
	}
	
	
}
