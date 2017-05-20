//
//  OrderVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON

import CoreLocation

class OrderVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet weak var myCollectionView: UICollectionView!
	class func instantiateFromStoryboard() -> OrderVC {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "ordervc") as! OrderVC
	}
	
	
	var date: String!
	var time: String!

	
	
	var myOrderSender = MyOrders()

	
	
	
	
	
	
	
	var myOrdersYet = [MyOrders]()

	
	
	
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	}
	
	
	
	

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if myOrdersYet.count == 0{
			_ = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: false);
		}
		return myOrdersYet.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ordercell", for: indexPath) as! OrderVCell
		
		cell.items.text = myOrdersYet[indexPath.row].itemNames
		cell.totalCost.text = myOrdersYet[indexPath.row].totalCost
		cell.orderDate.text = myOrdersYet[indexPath.row].date
		cell.orderTime.text = myOrdersYet[indexPath.row].time
		cell.placeImage.kf.setImage(with: myOrdersYet[indexPath.row].imageLink)
		cell.placeName.text = myOrdersYet[indexPath.row].placeName

		
		return cell
	}
	
	
	
	func updateView(){
		
		if myOrdersYet.count == 0{
			_ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: false);

		}
		myCollectionView.reloadData()
		
	}
	
	
	
	
	
	
	func apiCall(){
		
		// MARK:- PROFILE MYORDERS
		
		var myOrder = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v22.php?method=myOrders")!)
		myOrder.httpMethod = "POST"
		let postStringForOrder="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
		print("\(postStringForOrder)")
		
		
		myOrder.httpBody = postStringForOrder.data(using: .utf8)
		
		let taskForOrder = URLSession.shared.dataTask(with: myOrder) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           
				//print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				var json = JSON(data: data!)
				print(json)
				let numberOfEvents =  json["response"]["data"].count
				print(numberOfEvents)
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						let orderOnce = MyOrders()
						orderOnce.address = json["response"]["data"][index]["address"].string!
						orderOnce.convFee = json["response"]["data"][index]["conv_fee"].string!
						orderOnce.deliveryCharge = json["response"]["data"][index]["delivery_charge"].string!
						orderOnce.itemCost = json["response"]["data"][index]["item_costs"].string!
						orderOnce.itemIds = json["response"]["data"][index]["item_ids"].string!
						orderOnce.itemNames = json["response"]["data"][index]["item_names"].string!
						orderOnce.itemQuantity = json["response"]["data"][index]["item_quantity"].string!
						orderOnce.orderId = json["response"]["data"][index]["id"].string!
						orderOnce.phone = json["response"]["data"][index]["phone"].string!
						orderOnce.placeId = json["response"]["data"][index]["place_id"].string!
						orderOnce.status = json["response"]["data"][index]["status"].string!
						orderOnce.totalCost = json["response"]["data"][index]["total_cost"].string!
						orderOnce.type = json["response"]["data"][index]["type"].string!
						orderOnce.userId = json["response"]["data"][index]["user_id"].string!
						orderOnce.userName = json["response"]["data"][index]["name"].string!
						orderOnce.timeStamp = json["response"]["data"][index]["timestamp"].string!
						orderOnce.photoForOrder = json["response"]["data"][index]["photo_link"].string!
						orderOnce.placeName = json["response"]["data"][index]["name"].string!
						
						orderOnce.imageLink = URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(orderOnce.placeId ?? "")/\(orderOnce.photoForOrder ?? "" ).png")!

						
						var  dateObtained = orderOnce.timeStamp.characters.split{$0 == " "}.map(String.init)
						self.date = "\(dateObtained[1] ) \(dateObtained[2] ) \(dateObtained[3] )"
						print(self.date)
						orderOnce.date = self.date
						
						var meridian = "AM"
						var hourValueSoft: Int!
						var timeObtained = dateObtained[4].characters.split{$0 == ":"}.map(String.init)
						if Int(timeObtained[0])! > 12 {
							hourValueSoft = Int(timeObtained[0])! - 12
							meridian = "PM"
						}else{
							hourValueSoft = Int(timeObtained[0])!
						}
						self.time = "\(hourValueSoft!):\(timeObtained[1]) \(meridian)"
						orderOnce.time = self.time
						
						print(self.time)
						
						
						

						self.myOrdersYet.append(orderOnce)


					}
					
				
				}
				
				
				
				
				
			}
		}
		
		taskForOrder.resume()
		
		
		
		
		
		
	}
	
	
	func getPlaceInfoById(_ placeId: String!){
		
		
		//MARK:- PLACEBYID
		
		
		var placeReq = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=getPlacebyId")!)
		placeReq.httpMethod = "POST"
		let postString="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d&place_id=\(placeId!)"
		print("\(postString)")
		
		
		placeReq.httpBody = postString.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: placeReq) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				
				
				
				
				let json = JSON(data: data!)
				print(json)
				let index = 0
				
				
				
				
				orderDetailsForUser.placeId = json["response"]["data"][index]["id"].string!
				orderDetailsForUser.placeName = json["response"]["data"][index]["name"].string!
				orderDetailsForUser.placeType = json["response"]["data"][index]["type"].string!
				let lat = json["response"]["data"][index]["latitude"].string!
				let long = json["response"]["data"][index]["longitude"].string!
				orderDetailsForUser.phoneNumber = json["response"]["data"][index]["phone"].string!
				orderDetailsForUser.placeRating = json["response"]["data"][index]["rating"].string!
				orderDetailsForUser.placeDescription = json["response"]["data"][index]["description"].string!
				orderDetailsForUser.placeAddress = json["response"]["data"][index]["address"].string!
				orderDetailsForUser.mapURL = json["response"]["data"][index]["maps_url"].string!
				orderDetailsForUser.placeType = json["response"]["data"][index]["type"].string!
				
				
				
				
				
				
				
				
				
				
				if(orderDetailsForUser.placeRating == ""){
					orderDetailsForUser.placeRating = "3.0"
				}
				
				orderDetailsForUser.photoLink = json["response"]["data"][index]["photo_link"].string!
				
				
				
				var photoLinkArray = orderDetailsForUser.photoLink.characters.split{$0 == ","}.map(String.init)
				if (photoLinkArray.count) > 0 {
					
					orderDetailsForUser.placeFirstImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(placeTransitionArray.placeId ?? "")/\(photoLinkArray[0] ).png")!
					
					//MARK:- set the place image
					
					
					
//					self.offerPlaceImage.kf.setImage(with: placeTransitionArray.placeFirstImageUrl)
					
					
				}
				if (photoLinkArray.count) > 1 {
					
					orderDetailsForUser.placeSecondImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(placeTransitionArray.placeId ?? "")/\(photoLinkArray[1] ).png")!
					
					
					
					
				}
				
//				self.offerPlaceLogo.kf.setImage(with: placeTransitionArray.placeSecondImageUrl)
				
				
				
				
				
				
				
				userLatitude = 28.4595
				userLongitude = 77.0266
				
				
				
				if let d = Float(lat) {
					if let e = Float(long) {
						let coordinate1 = CLLocation(latitude: CLLocationDegrees(d),longitude: CLLocationDegrees(e))
						let coordinate2 = CLLocation(latitude: userLatitude,longitude: userLongitude)
						let distanceInMetres = coordinate1.distance(from: coordinate2)
						
						var V = Float(distanceInMetres)
						if(distanceInMetres <= 1000){
							
							orderDetailsForUser.placeDistance = "\(V)"+" metres"
						}else {
							V /= 1000
							orderDetailsForUser.placeDistance = "\(V)"+" KM"
						}
						
						
						
					}
				}
				
				
			}
			
		}
		
		task2.resume()
	}


	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		getPlaceInfoById(myOrdersYet[indexPath.row].placeId)
		
		
		myOrderSender.address = myOrdersYet[indexPath.row].address
		myOrderSender.convFee = myOrdersYet[indexPath.row].convFee

		myOrderSender.deliveryCharge = myOrdersYet[indexPath.row].deliveryCharge
		myOrderSender.itemCost = myOrdersYet[indexPath.row].itemCost
		myOrderSender.itemIds = myOrdersYet[indexPath.row].itemIds
		myOrderSender.itemNames = myOrdersYet[indexPath.row].itemNames
		myOrderSender.itemQuantity = myOrdersYet[indexPath.row].itemQuantity
		myOrderSender.phone = myOrdersYet[indexPath.row].phone
		myOrderSender.placeId = myOrdersYet[indexPath.row].placeId
		myOrderSender.status = myOrdersYet[indexPath.row].status
		myOrderSender.totalCost = myOrdersYet[indexPath.row].totalCost
		myOrderSender.type = myOrdersYet[indexPath.row].type
		myOrderSender.userId = myOrdersYet[indexPath.row].userId
		myOrderSender.userName = myOrdersYet[indexPath.row].userName
		myOrderSender.imageLink = myOrdersYet[indexPath.row].imageLink


		
		
		
		
		
		
		
		
		performSegue(withIdentifier: "OrderAdvance", sender: self)
	}
	
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		apiCall()
		// remove ordersdetail value
		

	}
	
	
	
	
	
	
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	
	
	if (segue.identifier == "OrderAdvance")
	 {
		
		let finalOrder = segue.destination as! OrderAdvance
		
		finalOrder.orderReceived.placeFirstImageUrl = orderDetailsForUser.placeFirstImageUrl
		finalOrder.orderReceived.placeImageLink = orderDetailsForUser.placeImageLink
		finalOrder.orderReceived.placeName = orderDetailsForUser.placeName
		finalOrder.orderReceived.phoneNumber = orderDetailsForUser.phoneNumber
		finalOrder.orderReceived.placeRating = orderDetailsForUser.placeRating
		finalOrder.orderReceived.placeId = orderDetailsForUser.placeId
		finalOrder.orderReceived.service = orderDetailsForUser.service
		
		
		
		
		
		finalOrder.myOrderreceiver.address = myOrderSender.address
		finalOrder.myOrderreceiver.convFee = myOrderSender.convFee
		finalOrder.myOrderreceiver.deliveryCharge = myOrderSender.deliveryCharge
		finalOrder.myOrderreceiver.itemCost = myOrderSender.itemCost
		finalOrder.myOrderreceiver.itemIds = myOrderSender.itemIds
		finalOrder.myOrderreceiver.itemNames = myOrderSender.itemNames
		finalOrder.myOrderreceiver.itemQuantity = myOrderSender.itemQuantity
		finalOrder.myOrderreceiver.phone = myOrderSender.phone
		finalOrder.myOrderreceiver.placeId = myOrderSender.placeId
		finalOrder.myOrderreceiver.status = myOrderSender.status
		finalOrder.myOrderreceiver.totalCost = myOrderSender.totalCost
		finalOrder.myOrderreceiver.type = myOrderSender.type
		finalOrder.myOrderreceiver.userId = myOrderSender.userId
		finalOrder.myOrderreceiver.userName = myOrderSender.userName
		finalOrder.myOrderreceiver.imageLink = myOrderSender.imageLink

		
		
		
	}
	
	

    }
	

}















