//
//  FoodCVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 16/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class FoodCVCell: UICollectionViewCell {
	
	
	@IBOutlet weak var foodPlaceImage: UIImageView!
	@IBOutlet weak var foodPlaceName: UILabel!
	@IBOutlet weak var foodPlaceDistance: UILabel!
	@IBOutlet weak var foodPlaceRating: UILabel!
	@IBOutlet weak var foodPlaceStatus: UILabel!
	
	@IBOutlet weak var locationImg: UIImageView!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		foodPlaceImage.backgroundColor = UIColor.leukRed()
		foodPlaceImage.image = UIImage(named: "dinnerPlace")
		foodPlaceImage.layer.cornerRadius = 8.0
		foodPlaceImage.clipsToBounds = true
		// Initialization code
		//foodPlaceImage.frame = CGRect(x: 0, y: 0, width: self.frame.width - 6, height: self.frame.height * 0.1)
	}
	
	
	
	
	
}
