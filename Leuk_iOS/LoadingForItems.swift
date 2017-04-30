//
//  LoadingForItems.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 30/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class LoadingForItems: UIViewController {

	var valueForLoad : Int!
	var totalValueHere: [Int]!
	var index1: Int!
	var menuFoodId: String!
	
    override func viewDidLoad() {
        super.viewDidLoad()
//	foodForShop.removeAll()
//	groceriesForShop.removeAll()
//	medicineForShop.removeAll()
//	stationaryForShop.removeAll()
	
	getTotalLength()
	
	//_ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
	getSegue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	
	func getTotalLength(){
		index1 = 0
		for cat in categoryOfItem {
			
			//secondGetLength(commonForShop, catVal: cat)
			var indexInside = 0
			for indexval in commonForShop {
				if indexval.itemCategory == cat {
					shopValuesByCategory[index1]!.append(indexval)
					//idValues[index1][indexInside] = idString!
					indexInside += 1
				}
			}
			
			index1 = index1 + 1
		}
		
		
		
		
		
	}
	
	
//	func secondGetLength(_ arrayItem: [shopMenuItem],catVal category: String!){
//		
//		
//		for singlyArray in foodForShop {
//			
//			if singlyArray.itemCategory == category {
//				//if totalValueHere[index] != 0{
//					totalValueHere[index] += 1
////				} else {
////					totalValueHere[index] = 1
////				}
//			}
//		}
//		
//		
//		
//		
//		
//		
//		
//	}
//	
//	
	func getSegue(){
		
		
		if commonForShop.count == 0 {
			DispatchQueue.main.async {
				
				_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
			}
		} else {
			callSegue()
		}
		
		
		
//		
//		if valueForLoad == 0 {
//			
//			if foodForShop.count == 0 {
//				DispatchQueue.main.async {
//					
//					_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
//				}
//			} else {
//				callSegue()
//			}
//			
//		} else if valueForLoad == 1 {
//			if groceriesForShop.count == 0 {
//				DispatchQueue.main.async {
//					
//					_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
//				}
//			} else {
//				callSegue()
//			}
//
//			
//		} else if valueForLoad == 2 {
//			if medicineForShop.count == 0 {
//				DispatchQueue.main.async {
//					
//					_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
//				}
//			} else {
//				callSegue()
//			}
//
//			
//			
//		} else if valueForLoad == 3 {
//			if stationaryForShop.count == 0 {
//				DispatchQueue.main.async {
//					
//					_ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getSegue), userInfo: nil, repeats: false);
//				}
//			} else {
//				callSegue()
//			}
//
//			
//		}
	
		
	
	
	}
	func callSegue(){
		
		self.performSegue(withIdentifier: "shopmenusecond", sender: self)
		
	}

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	if (segue.identifier == "shopmenusecond") {
		
		let shopMenuVC = segue.destination as! ShopMenu
		shopMenuVC.indexValueShop = self.valueForLoad
		shopMenuVC.totalValueHere = self.totalValueHere
		shopMenuVC.menuFoodId = self.menuFoodId
		
	
		
	}
	
	
	
    }
	

}
