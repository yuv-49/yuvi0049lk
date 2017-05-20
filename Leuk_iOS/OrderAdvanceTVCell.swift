//
//  OrderAdvanceTVCell.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 08/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class OrderAdvanceTVCell: UITableViewCell {

	@IBOutlet weak var itemName: UILabel!
	@IBOutlet weak var itemCost: UILabel!
	@IBOutlet weak var itemQty: UILabel!
	@IBOutlet weak var itemSum: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
