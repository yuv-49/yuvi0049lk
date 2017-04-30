//
//  FoodCVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 16/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"

class FoodCVC: UICollectionViewController {
	//var indexValues: Int!
	var indexValueSecond: Int!
	var menuFoodId: String!
	var valueForSecondApiCall: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

	valueForSecondApiCall = 1000
//	groceriesForShop.removeAll()
//	foodForShop.removeAll()
//	medicineForShop.removeAll()
//	stationaryForShop.removeAll()
	
	
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	
	

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
	if(indexValueSecond == 0){
		return restaurantOrder.count
	}
	else if(indexValueSecond == 1){
		return GroceriesOrder.count
	}
	else if(indexValueSecond == 2){
		return MedicineOrder.count
	}
	else {
		return staitionaryOrder.count
	}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodcvcell", for: indexPath) as! FoodCVCell
    
	  if(indexValueSecond == 0){
		  updateValues(restaurantOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 1){
		  updateValues(GroceriesOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 2){
		  updateValues(MedicineOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 3){
		  updateValues(staitionaryOrder, cellForRow: indexPath, TableCell: cell)
	  }
	
	
	return cell
	}
	
	
	func updateValues(_ valueForPlaces:[Places],cellForRow indexPath: IndexPath, TableCell TVcell:FoodCVCell ){
		
		
		
		
		if(valueForPlaces[indexPath.row].placeFirstImageUrl != nil){
			
			
			TVcell.foodPlaceImage.kf.setImage(with: valueForPlaces[indexPath.row].placeFirstImageUrl)
		} else {
			print("Add the default image on places")
		}
		
		
		
		
		TVcell.foodPlaceName.text = valueForPlaces[indexPath.row].placeName
		TVcell.foodPlaceDistance.text = valueForPlaces[indexPath.row].placeDistance
		//TVcell.foodPlaceImage.image = valueForPlaces[indexPath.row].placeImage
		TVcell.foodPlaceRating.text = valueForPlaces[indexPath.row].placeRating
		TVcell.foodPlaceRating.text?.append("★")

		
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	//	let indexPathValues = collectionView.indexPathsForSelectedItems
		
		
		
		if(indexValueSecond == 0){
			
		    menuFoodId = restaurantOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			self.performSegue(withIdentifier: "shopmenufirst", sender: self)

			
			
		}
		else if(indexValueSecond == 1){
			menuFoodId = GroceriesOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			self.performSegue(withIdentifier: "shopmenufirst", sender: self)

			
		}
		else if(indexValueSecond == 2){
			menuFoodId = MedicineOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			self.performSegue(withIdentifier: "shopmenufirst", sender: self)

			
		}
		else if(indexValueSecond == 3){
			menuFoodId = staitionaryOrder[indexPath.row].placeId
			if valueForSecondApiCall != indexPath.row {
				apiCallForMenu(menuFoodId,indexx: indexPath)
			}
			self.performSegue(withIdentifier: "shopmenufirst", sender: self)

			
		}
		
//		if categoryOfItem.count != 0 {
//			self.performSegue(withIdentifier: "shopmenufirst", sender: self)
//		} else {
//			
//		}
		

	}
	
	
	
	
	
	func apiCallForMenu(_ placeId: String,indexx path: IndexPath){
		
		// MARK:- api call for number of category
		
		
		
		var getMenuCategory = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v22.php?method=getMenuCategory")!)
		getMenuCategory.httpMethod = "POST"
		let postValue11="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d&place_id=\(placeId)"
		print("YSHSHSHSHSHS \(postValue11)")
		
		
		getMenuCategory.httpBody = postValue11.data(using: .utf8)
		
		let task = URLSession.shared.dataTask(with: getMenuCategory) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				categoryOfItem.removeAll()
				var json = JSON(data: data!)
				let numberOfItems = json["response"]["data"].count
				if numberOfItems > 0 {

					for index in 0...numberOfItems-1 {
						
						let value = json["response"]["data"][index]["category"].string!
						categoryOfItem.append(value)
				//MARK MARK
//						if categoryOfItem.count != 0 {
//							for cat in categoryOfItem {
//								if cat != value {
//									categoryOfItem.append(value)
//									//print(value)
//								}
//							}
//						}
//						else {
//							categoryOfItem.append(value)
//						}
						
						
					}
				
				
				
				}
		
			}
		}
		task.resume()
		
		
		
		
		// MARK: - placeid
		
		
		
		
		
		
		
		
		commonForShop.removeAll()

		
		
		// MARK:- Api call for next page
		
		var getMenu = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=getMenu")!)
		getMenu.httpMethod = "POST"
		let postValue="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d&place_id=\(placeId)"
		print("YSHSHSHSHSHS \(postValue)")
		
		
		getMenu.httpBody = postValue.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: getMenu) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				var json = JSON(data: data!)
				print(json)
				let numberOfItems = json["response"]["data"].count
				print(numberOfItems)
				if numberOfItems > 0
				{
					
					for index in 0...numberOfItems-1 {
						let menuList = shopMenuItem()
						menuList.itemId = json["response"]["data"][index]["id"].string!
						menuList.itemNonVeg = json["response"]["data"][index]["non_veg"].string!
						menuList.itemOfferCost = json["response"]["data"][index]["offer_cost"].string!
						menuList.itemCategory = json["response"]["data"][index]["category"].string!
						menuList.itemDescription = json["response"]["data"][index]["description"].string!
						menuList.itemName = json["response"]["data"][index]["item_name"].string!
						menuList.itemLimit = json["response"]["data"][index]["item_limit"].string!
						menuList.itemVeg = json["response"]["data"][index]["veg"].string!
						menuList.itemtags = json["response"]["data"][index]["tags"].string!
						menuList.itemspicy = json["response"]["data"][index]["spicy"].string!
						menuList.itemLove = json["response"]["data"][index]["love"].string!
						menuList.itemImageLink = json["response"]["data"][index]["image"].string!
						menuList.itemPlaceId = json["response"]["data"][index]["place_id"].string!
						menuList.itemRegularCost = json["response"]["data"][index]["regular_cost"].string!
			
					
						
						commonForShop.append(menuList)
						
//					
//						if(menuList.itemCategory != nil){
//					
//						
//						if(self.indexValueSecond == 0){
//							
//							foodForShop.append(menuList)
//							//print(menuList.itemCategory)
//							
////							for value in foodForShop {
////								if value.itemCategory != menuList.itemCategory {
////									self.categoryOfItem.append(menuList.itemCategory)
////									//print(menuList.itemCategory)
////									
////								}
////							}
//							
//						}
//						else if(self.indexValueSecond == 1){
//							groceriesForShop.append(menuList)
//						}
//						else if(self.indexValueSecond == 2){
//							medicineForShop.append(menuList)
//							
//							
//							
//						}
//						else if(self.indexValueSecond == 3){
//							stationaryForShop.append(menuList)
//							
//						}
//						}
//				
					
					}
				}
				
			
			
			}
		}
		
		task2.resume()
		self.valueForSecondApiCall = path.row
		
	}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if (segue.identifier == "shopmenu") {
//			
//			let shopMenuVC = segue.destination as! ShopMenu
//			
//			if self.indexValueSecond == 0 {
//				shopMenuVC.indexValueShop = 0
//				
//			} else if self.indexValueSecond == 1 {
//				shopMenuVC.indexValueShop = 1
//				
//			} else if self.indexValueSecond == 2 {
//				shopMenuVC.indexValueShop = 2
//				
//			} else {
//				shopMenuVC.indexValueShop = 3
//				
//			}
//			
//			
//			
//			
//		} else
			if segue.identifier == "shopmenufirst" {
			let shopMenuVC = segue.destination as! LoadingForItems
			
			if self.indexValueSecond == 0 {
				shopMenuVC.valueForLoad = 0
				shopMenuVC.menuFoodId = menuFoodId
				
			} else if self.indexValueSecond == 1 {
				shopMenuVC.valueForLoad = 1
				shopMenuVC.menuFoodId = menuFoodId

				
			} else if self.indexValueSecond == 2 {
				shopMenuVC.valueForLoad = 2
				shopMenuVC.menuFoodId = menuFoodId

				
			} else {
				shopMenuVC.valueForLoad = 3
				shopMenuVC.menuFoodId = menuFoodId

				
			}
		}
	}
	
	
	
	
	
	

}
