//
//  OrderAdvance.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 08/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class OrderAdvance: UIViewController , UITableViewDelegate, UITableViewDataSource{

	@IBOutlet weak var placeImage: UIImageView!
	@IBOutlet weak var totalPrice: UILabel!
	@IBOutlet weak var placeName: UILabel!
	@IBOutlet weak var deliveryTime: UILabel!
	@IBOutlet weak var placeRating: UILabel!
	
	var orderReceived = Places()
	var myOrderreceiver = MyOrders()
	var orderNames =  [String]()
	var orderQtys = [String]()
       var orderPrices = [String]()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
	//let link = URL(string:orderReceived.placeFirstImageUrl )!
	
//	if self.placeImage.image == nil {
//		self.placeImage.kf.setImage(with: )
//		
//	}
	
	self.placeImage.kf.setImage(with: myOrderreceiver.imageLink)
	print(orderReceived.placeFirstImageUrl)
	
	totalPrice.text = myOrderreceiver.totalCost
	placeName.text = orderReceived.placeName
	placeRating.text = orderReceived.placeRating
	
	computeTableCells()

	
	
	}
	
	
	
	
	func computeTableCells(){
		orderNames  = myOrderreceiver.itemNames.characters.split{$0 == ","}.map(String.init)
		orderQtys = myOrderreceiver.itemQuantity.characters.split{$0 == ","}.map(String.init)
		orderPrices = myOrderreceiver.itemCost.characters.split{$0 == ","}.map(String.init)
		
	}
	
	
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return orderPrices.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "OrderAdvanceTVCell", for: indexPath) as! OrderAdvanceTVCell

		cell.itemName.text = orderNames[indexPath.row]
		cell.itemCost.text = orderPrices[indexPath.row]
		cell.itemQty.text = orderQtys[indexPath.row]
		let computeTotal = Int(orderQtys[indexPath.row])! * Int(orderPrices[indexPath.row])!
		cell.itemSum.text =  "\(computeTotal)"
		
		
		
		return cell
	}
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
