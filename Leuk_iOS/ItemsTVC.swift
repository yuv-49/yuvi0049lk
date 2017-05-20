//
//  ItemsTVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 30/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class ItemsTVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
	
       @IBOutlet weak var myTable: UITableView!
	@IBOutlet weak var cartSum: UILabel!
	
	@IBOutlet weak var cartShow: UIView!
	
	
	var indexValueReceiver : Int!
	var addBtnClicked: Bool!
	
	var totalCartValue: Int!
	
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

	
		let gestureForView = UITapGestureRecognizer(target: self, action:  #selector (self.showCart (_:)))
		self.cartShow.addGestureRecognizer(gestureForView)
		
		
		
		
	addBtnClicked = false
	
		getTotalCartValue()
		
		
	
	}
	
	func getTotalCartValue(){
		
		totalCartValue = 0
		
		cartSum.text = "0"
		if cartValues.count != 0 {
			totalCartValue = 0
			
			for val in cartValues {
				totalCartValue = totalCartValue + (val.rows * Int(val.itemOfferCost)!)
				
			}
			
			cartSum.text = "\(totalCartValue!)"
		}
	}

	func showCart(_ sender:UITapGestureRecognizer){
		
		if totalCartValue != 0 {

			self.performSegue(withIdentifier: "CartVC", sender: self)
		}

		
	}
	
	
	
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	

	if commonForShopAtlast1.count == 0{
		DispatchQueue.main.async {
			_ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false)
		}
		
	}
	return commonForShopAtlast1.count
	}
	
	func reload(){
		
		if commonForShopAtlast1.count != 0 {
			if cartValues.count != 0 {
		
			 for value in commonForShopAtlast1 {
				 for val in cartValues {
					 if val.itemId == value.itemId {
						 value.rows = val.rows
					 }
				 }
			 }
			}
		}
		
		myTable.reloadData()
	}
	
	
	
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	

	let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTVCell", for: indexPath) as! ItemsTVCell

	
	cell.itemName.text = commonForShopAtlast1[indexPath.row].itemName
	
	cell.itemQuantity.text = "0"

	if commonForShopAtlast1[indexPath.row].rows != 0 {
		cell.itemQuantity.text = "\(commonForShopAtlast1[indexPath.row].rows!)"

	}
	
	
	if addBtnClicked {
		cell.itemQuantity.text = "\(commonForShopAtlast1[indexPath.row].rows!)"
	}
	
	
	
	cell.add.tag = indexPath.row
	cell.add.addTarget(self, action: #selector(self.addItem(_:)), for: .touchUpInside)
	cell.substract.tag = indexPath.row
	cell.substract.addTarget(self, action: #selector(self.deleteItem(_:)), for: .touchUpInside)

	
	let link = URL(string: commonForShopAtlast1[indexPath.row].itemImageLink)!
	cell.itemImage.kf.setImage(with: link)

	
	
	
	
	  if commonForShopAtlast1[indexPath.row].itemOfferCost != commonForShopAtlast1[indexPath.row].itemRegularCost {
		  cell.realCost.text = commonForShopAtlast1[indexPath.row].itemRegularCost
		  cell.offerCost.text = commonForShopAtlast1[indexPath.row].itemOfferCost
	  }else {
		  cell.realCost.text = ""
		  cell.offerCost.text = commonForShopAtlast1[indexPath.row].itemOfferCost
	  }
	
	 
	
	
	
	 return cell
	}
	
	
	
	func addItem(_ button: UIButton) {
		let clicked = button.tag
		
		commonForShopAtlast1[clicked].rows = commonForShopAtlast1[clicked].rows + 1
		
		
		print("out")
		addBtnClicked = true
		
		
		
		var sum = 0
		for val in cartValues {
			if val.itemId == commonForShopAtlast1[clicked].itemId {
				val.rows = commonForShopAtlast1[clicked].rows
				sum = 1
			}
		}
		if sum == 0{
			cartValues.append(commonForShopAtlast1[clicked])
		}
		totalCartValue = 0
		for val in cartValues {
			totalCartValue = totalCartValue + (val.rows * Int(val.itemOfferCost)!)
		}

		cartSum.text = "\(totalCartValue!)"
		let indexPath = IndexPath(item: button.tag, section: 0)
		myTable.reloadRows(at: [indexPath], with: .none)
		
	}
	
	
	
	func deleteItem(_ button: UIButton) {

		
		let clicked = button.tag
		
		commonForShopAtlast1[clicked].rows = commonForShopAtlast1[clicked].rows - 1
		if commonForShopAtlast1[clicked].rows <= 0 {
			commonForShopAtlast1[clicked].rows = 0
		} else {
//			do something but not now
		}
		
		
		print("out")
		addBtnClicked = true
		
		
		
		for val in cartValues {
			if val.itemId == commonForShopAtlast1[clicked].itemId {
				val.rows = commonForShopAtlast1[clicked].rows
				
			} else {
				print("nana not here")
			}
		}
		totalCartValue = 0
		for val in cartValues {
			totalCartValue = totalCartValue + (val.rows * Int(val.itemOfferCost)!)
		}
		
		cartSum.text = "\(totalCartValue!)"
		
		let indexPath = IndexPath(item: button.tag, section: 0)
		myTable.reloadRows(at: [indexPath], with: .none)

		
		
		
	}
	

	
	
	
	override func viewDidAppear(_ animated: Bool) {
		
		getTotalCartValue()
		myTable.reloadData()
	
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
































