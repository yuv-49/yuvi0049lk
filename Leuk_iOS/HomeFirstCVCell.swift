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
//		view.layer.shadowColor = UIColor.gray.cgColor
//		//view.layer.shadowPath = UIBezierPath(roundedRect:view.bounds, cornerRadius:view.contentView.layer.cornerRadius).cgPath
//		view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//		view.layer.shadowRadius = 2.0
//
//		view.layer.masksToBounds = false
//		view.layer.shadowOpacity = 1.0
//		

//		view.layer.shadowColor = UIColor.black.cgColor
//		view.layer.shadowOpacity = 1
//		view.layer.shadowOffset = CGSize.zero
//		view.layer.shadowRadius = 10
//		
//		view.layer.shouldRasterize = true

		
		
		
		
//		view.layer.borderWidth = 2
//		view.layer.borderColor = UIColor.lightGray.cgColor
		self.addSubview(view)
		
		
		
		
		
		
		
		
		
//		cell.contentView.layer.cornerRadius = 10
//		cell.contentView.layer.borderWidth = 1.0
//		
//		cell.contentView.layer.borderColor = UIColor.clear.cgColor
//		cell.contentView.layer.masksToBounds = true
//		
//		cell.layer.shadowColor = UIColor.gray.cgColor
//		cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//		cell.layer.shadowRadius = 2.0
//		cell.layer.shadowOpacity = 1.0
//		cell.layer.masksToBounds = false
//		cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
		
		
		
	}
	
	
}
