//
//  ItemsTVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 30/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit



class ItemsTVCell: UITableViewCell {
	
	@IBOutlet weak var itemVeg: UIImageView!
	@IBOutlet weak var itemName: UILabel!
	@IBOutlet weak var offerCost: UILabel!
	@IBOutlet weak var realCost: UILabel!
	@IBOutlet weak var itemSpicy: UIImageView!
	@IBOutlet weak var itemQuantity: UILabel!
	@IBOutlet weak var itemImage: UIImageView!
	
//	@IBOutlet weak var AddCart: UIButton!
	
	
	@IBOutlet weak var substract: UIButton!
	@IBOutlet weak var add: UIButton!
	
	
	
	
      

	
	
	@IBAction func itemSubstract(_ sender: Any) {
		
	//	itemQuantity.text =
		
//		if itemQuantityInNumber != 0{
//			itemQuantityInNumber = itemQuantityInNumber - 1
//			itemQuantity.text = "\(itemQuantityInNumber!)"
//			updateCart()
//		}else {
//			itemQuantityInNumber = 0
//			itemQuantity.text = "\(itemQuantityInNumber!)"
//			updateCart()
//		}
//		
		
	}
	
	@IBAction func itemAdd(_ sender: Any) {
//		itemQuantityInNumber = itemQuantityInNumber + 1
//		itemQuantity.text = ""
//		itemQuantity.text = "\(itemQuantityInNumber!)"
	}
	

	func updateCart(){
		
		
		
	
	}
	
	
	
	
	
	
	
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
	//itemQuantityInNumber = 0
	//itemQuantity.text = "0"
	
	itemImage.backgroundColor = UIColor.leukRed()
	itemImage.layer.cornerRadius = 8.0
	itemImage.clipsToBounds = true
	
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
