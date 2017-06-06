//
//  CartTVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 01/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class CartTVCell: UITableViewCell {
	
	
//	@IBOutlet weak var itemImage: UIImageView!
//	@IBOutlet weak var itemName: UILabel!
//	@IBOutlet weak var itemOfferCost: UILabel!
//	@IBOutlet weak var itemOriginalCost: UILabel!
//	@IBOutlet weak var youSaveLabel: UILabel!
//	@IBOutlet weak var quantityLabel: UILabel!
//	@IBOutlet weak var addBtn: UIButton!
//	@IBOutlet weak var subBtn: UIButton!
//	
	
	
	
	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var itemName: UILabel!
	@IBOutlet weak var itemCost: UILabel!
	@IBOutlet weak var numberOfItems: UILabel!
	@IBOutlet weak var addItem: UIButton!
	@IBOutlet weak var substractItem: UIButton!
	
	
	
	
	
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	
	itemImage.backgroundColor = UIColor.leukRed()
	itemImage.layer.cornerRadius = 8.0
	itemImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
