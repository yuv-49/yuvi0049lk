//
//  PlacesFirstTVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 11/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class PlacesFirstTVCell: UICollectionViewCell {
	
	@IBOutlet weak var placeImage: UIImageView!
	@IBOutlet weak var placeName: UILabel!
	@IBOutlet weak var placceType: UILabel!
	@IBOutlet weak var placeDistance: UILabel!
	@IBOutlet weak var placeRating: UILabel!
//	@IBOutlet weak var placePremium: UILabel!
	@IBOutlet weak var placeReviews: UILabel!
	@IBOutlet weak var placeViews: UILabel!
	
	
	
	
	
	
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	
	placeImage.backgroundColor = UIColor.leukRed()
	//placeImage.image = UIImage(named: "dinnerPlace")
	placeImage.layer.cornerRadius = 8.0
	placeImage.clipsToBounds = true
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
