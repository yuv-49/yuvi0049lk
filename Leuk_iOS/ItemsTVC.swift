//
//  ItemsTVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 30/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class ItemsTVC: UITableViewController {
	
	
	var quantityArray = [Any]()
	var orderValue : [Int]!
	
	var itemCount: [Int]!
	
	var virtual = shopMenuItem()
	
	var addBtnClicked : Bool!
	var minusBtnClicked : Bool!

    override func viewDidLoad() {
        super.viewDidLoad()
	var i = 0
	for common in commonForShopAtLast {
		common.rows = 0
		//orderValue[i] = 0
		i += 1
	}
	
	
	addBtnClicked = false
	minusBtnClicked = false
	
	
	
	
	//MARK:- navigationbar
	
	
	
	let btn1 = UIButton(type: .custom)
	btn1.setImage(UIImage(named: "parties"), for: .normal)
	btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
	btn1.addTarget(self, action: #selector(self.callCartScene), for: .touchUpInside)
	let item1 = UIBarButtonItem(customView: btn1)
	self.navigationItem.setRightBarButtonItems([item1], animated: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	func callCartScene(){
		
		
		
		
		
		
		
		
		
		
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
	if commonForShopAtLast.count != 0{
	   return commonForShopAtLast.count
	} else {
		_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
		return commonForShopAtLast.count
	}
    }
	func reload(){
		tableView.reloadData()
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTVCell", for: indexPath) as! ItemsTVCell

	if commonForShopAtLast.count != 0{
		cell.itemName.text = commonForShopAtLast[indexPath.row].itemName
//		cell.add.tag = indexPath.row
//		cell.substract.tag = indexPath.count + indexPath.row
		
		cell.add.addTarget(self, action: #selector(self.addItem(_:)), for: .touchUpInside)

		cell.substract.addTarget(self, action: #selector(self.deleteItem(_:)), for: .touchUpInside)
		
		
		if addBtnClicked || minusBtnClicked {
			if cartValues[indexPath.row].rows != nil {
			  cell.itemQuantity.text = "\(cartValues[indexPath.row].rows!)"
				
			  addBtnClicked = false
			  minusBtnClicked = false
			}
			else {
				cell.itemQuantity.text = "0"
			}
		}
		else {
			cell.itemQuantity.text = "0"
		}
		
		
		
		
		
		
		
		if commonForShopAtLast[indexPath.row].itemOfferCost != commonForShopAtLast[indexPath.row].itemRegularCost {
			cell.realCost.text = commonForShopAtLast[indexPath.row].itemRegularCost
			cell.offerCost.text = commonForShopAtLast[indexPath.row].itemOfferCost
		}else {
			cell.realCost.text = ""
			cell.offerCost.text = commonForShopAtLast[indexPath.row].itemOfferCost
		}
	} else {
		_ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.reload), userInfo: nil, repeats: false);
	}
	
        return cell
    }
	
	
//	func checkButtonTapped(_ sender: Any) {
//		let buttonPosition = sender.convertPoint(CGPoint.zero, to: tableView)
//		let indexPath: IndexPath? = tableView.indexPathForRow(at: buttonPosition)
//		if indexPath != nil {
//			
//		}
//	}
	
	
	func addItem(_ button: UIButton) {
		let touchPoint = button.convert(CGPoint.zero, to: tableView)
		let clickedButtonIndexPath: IndexPath? = tableView.indexPathForRow(at: touchPoint)
		
		 addBtnClicked = true
		let temp = shopMenuItem()
		temp.itemId = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemId
		temp.itemNonVeg = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemNonVeg
		temp.itemCategory = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemCategory
		temp.itemOfferCost = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemOfferCost
		temp.itemDescription = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemDescription
		temp.itemName = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemName
		temp.itemLimit = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemLimit
		temp.itemVeg =  commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemVeg
		temp.itemtags = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemtags
		temp.itemspicy = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemspicy
		temp.itemLove =  commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemLove
		temp.itemImageLink = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemImageLink
		temp.itemPlaceId = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemPlaceId
		temp.itemRegularCost = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemRegularCost
		
		//itemCount[(clickedButtonIndexPath?.row)!] +=  1
		
		if cartValues[(clickedButtonIndexPath?.row)!].rows != nil {
			cartValues[(clickedButtonIndexPath?.row)!].rows = cartValues[(clickedButtonIndexPath?.row)!].rows + 1
			print(cartValues[(clickedButtonIndexPath?.row)!].itemId)
			//temp.rows = temp.rows + 1
			
//			for values in cartValues {
//				if values.itemId == temp.itemId {
//					
//					
//					
//					
//					cartValues.remove(at: (clickedButtonIndexPath?.row)!)
//					//print(temp.itemId)
//					cartValues.insert(temp, at: (clickedButtonIndexPath?.row)!)
//					print(temp.itemId)
////					let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
////					tableView.reloadRows(at: [indexPath], with: .none)
//				}
//			}
			
		}else {
			temp.rows = 1
			cartValues.insert(temp, at: (clickedButtonIndexPath?.row)!)
			print(temp.itemId)

//			let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
//			tableView.reloadRows(at: [indexPath], with: .none)
		}

		
		
		let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
		tableView.reloadRows(at: [indexPath], with: .none)
	}
	
	
	
	func deleteItem(_ button: UIButton) {
		let touchPoint = button.convert(CGPoint.zero, to: tableView)
		let clickedButtonIndexPath: IndexPath? = tableView.indexPathForRow(at: touchPoint)
		
		minusBtnClicked = true
		let temp = shopMenuItem()
		temp.itemId = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemId
		temp.itemNonVeg = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemNonVeg
		temp.itemCategory = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemCategory
		temp.itemOfferCost = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemOfferCost
		temp.itemDescription = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemDescription
		temp.itemName = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemName
		temp.itemLimit = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemLimit
		temp.itemVeg =  commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemVeg
		temp.itemtags = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemtags
		temp.itemspicy = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemspicy
		temp.itemLove =  commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemLove
		temp.itemImageLink = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemImageLink
		temp.itemPlaceId = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemPlaceId
		temp.itemRegularCost = commonForShopAtLast[(clickedButtonIndexPath?.row)!].itemRegularCost
		
		if cartValues[(clickedButtonIndexPath?.row)!].rows != nil {
			cartValues[(clickedButtonIndexPath?.row)!].rows = cartValues[(clickedButtonIndexPath?.row)!].rows - 1
			print(cartValues[(clickedButtonIndexPath?.row)!].itemId)
			//temp.rows = temp.rows - 1
			if cartValues[(clickedButtonIndexPath?.row)!].rows < 0 {
				cartValues[(clickedButtonIndexPath?.row)!].rows = 0
				
//				temp.rows = 0
//				for values in cartValues {
//					if temp.itemId == values.itemId {
//						print(temp.itemId)
//						cartValues.remove(at: (clickedButtonIndexPath?.row)!)
//						
//
////						let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
////						tableView.reloadRows(at: [indexPath], with: .none)
//						
//					}
//				}
			} else {
				//print(temp.itemId)
				
				//cartValues[(clickedButtonIndexPath?.row)!].rows
				
				
				
//				cartValues.remove(at: (clickedButtonIndexPath?.row)!)
//				cartValues.insert(temp, at: (clickedButtonIndexPath?.row)!)

				
//				let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
//				tableView.reloadRows(at: [indexPath], with: .none)
			}
			
		} else {
			//temp.rows = 0
		}
		
		let indexPath = IndexPath(item: (clickedButtonIndexPath?.row)!, section: 0)
		tableView.reloadRows(at: [indexPath], with: .none)
	}
	

	
	
	
	override func viewDidAppear(_ animated: Bool) {
		addBtnClicked = false
		minusBtnClicked = false
		
		for _ in 0..<40 {
			cartValues.append(virtual)
			
		}
	}
	
//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTVCell", for: indexPath) as! ItemsTVCell
//		if addBtnClicked || minusBtnClicked {
//			if cartValues[indexPath.row].rows != nil {
//				cell.itemQuantity.text = "\(cartValues[indexPath.row].rows!)"
//				addBtnClicked = false
//				minusBtnClicked = false
//			}
//			else {
//				cell.itemQuantity.text = "0"
//			}
//		}
//		else {
//			cell.itemQuantity.text = "0"
//		}
//	}
	
	
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
