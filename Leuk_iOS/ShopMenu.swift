//
//  ShopMenu.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShopMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	
       var indexValueShop: Int!
	var totalValueHere: [Int]!
	var menuFoodId: String!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

	let btn1 = UIButton(type: .custom)
	btn1.setImage(UIImage(named: "parties"), for: .normal)
	btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
	btn1.addTarget(self, action: #selector(self.callCartScene), for: .touchUpInside)
	let item1 = UIBarButtonItem(customView: btn1)
	
	self.navigationItem.setRightBarButtonItems([item1], animated: true)
	
	
    }
	
	
	func callCartScene(){
		
		
		
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK:- tableview functionalities
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryOfItem.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ShopMenuTVCell", for: indexPath) as! ShopMenuTVCell
		
		cell.itemName.text = categoryOfItem[indexPath.row]
		
		
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		let categoryVal = categoryOfItem[indexPath.row]
		
		apiCall(categoryVal)
		
		
	}
	
	
	
	func apiCall(_ value: String){
		
		
		
		// MARK:- Api call for next page
		
		var getMenu = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v22.php?method=getMenubyCategory")!)
		getMenu.httpMethod = "POST"
		let postValue="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d&place_id=\(menuFoodId!)&category=\(value)"
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
					commonForShopAtLast.removeAll()
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
						
						
						
						commonForShopAtLast.append(menuList)
						
						
						
					}
				}
				
				
				
			}
		}
		
		task2.resume()
		
		self.performSegue(withIdentifier: "shopconnect", sender: self)

		
		
	}
	
       override func viewDidAppear(_ animated: Bool) {
		commonForShopAtLast.removeAll()
	}
	
	
	func getItemForCategory(_ listArrayForItem: [shopMenuItem]) {
		
	
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