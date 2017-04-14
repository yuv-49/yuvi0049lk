//
//  LoadingDataVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoadingDataVC: UIViewController {
	
	var countOfPlaces: String!
	var tokenIdFromGoogle: String!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
	
	// print("Happy singh: \(tokenId)")
	
	
	getApi()

	
	
	
	
    }
	
	
	func getApi(){
		
		var request1 = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=generateSession")!)
		request1.httpMethod = "POST"
		let postString =  "key=leuk12&secret=gammayz&google_auth_token_id=\(tokenIdFromGoogle!)"
		print("hello world \(postString)")
		request1.httpBody = postString.data(using: .utf8)
		
		let task1 = URLSession.shared.dataTask(with: request1) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				//print("RFc")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
			 var json = JSON(data: data!)
			 sessionId = json["response"]["data"]["session"]["sessionid"].string!
			 tokenId = json["response"]["data"]["session"]["token"].string!
				// print("sess tok \(sessionId)             \(tokenId)")
				
				
			}
		}
		task1.resume()
		
		
		
		// MARK:- PROFILE
		
		var profileRequest = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v19.php?method=getUserInfo")!)
		profileRequest.httpMethod = "POST"
		let postString1="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
		print("\(postString1)")
		
		
		profileRequest.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				//print("RFcss")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
				
				
				
				
				var json = JSON(data: data!)
				Name = json["response"]["data"]["name"].string!
				area = json["response"]["data"]["location"].string!
				referalCode = json["response"]["data"]["referral_code"].string!
				level = json["response"]["data"]["level"].string!
				profileImages = json["response"]["data"]["profile_img"].string!
				totalCredits = json["response"]["data"]["total_credits"].string!
				remainingCredits = json["response"]["data"]["remaining_credits"].string!
				print(Name)
			}
		}
		
		task2.resume()

		
		
		
		
		// MARK:- get offers
		
		
		
		
		var mytickets = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v19.php?method=getOffers")!)
		mytickets.httpMethod = "POST"
		let postString2="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
		
		
		mytickets.httpBody = postString2.data(using: .utf8)
		
		let task3 = URLSession.shared.dataTask(with: mytickets) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				//print("GET OFFERS tab over --------------------")
				var json = JSON(data: data!)
				let numberOfPlaces =  json["response"]["data"].count
				//print(numberOfPlaces)
				if numberOfPlaces > 0
				{  for index in 0...numberOfPlaces-1 {
					let a = homeOffers()
					a.discountPercentage = json["response"]["data"][index]["offer_title"].string!
					a.image = json["response"]["data"][index]["offer_image_link"].string!
					a.left = json["response"]["data"][index]["coupon_credit_cost"].string!
					a.title = json["response"]["data"][index]["offer_by"].string!
					a.type = json["response"]["data"][index]["category"].string!
					
					if (a.type == "bars"){
						homeOffersBars.append(a)
					}else if (a.type == "apparels"){
						homeOfferesApparels.append(a)
					}else if (a.type == "fnb") {
						homeOffersF_B.append(a)
					}else if (a.type == "Hpy Hrs") {
						homeOffersHappy.append(a)
					}else if (a.type == "Sports") {
						homeOffersSports.append(a)
					}
					
					//else if (a.type == "") One left to add later
					
					
					}}
				
			}
		}
		
		task3.resume()
		
		
		// MARK:- total places count
		
		
		
		
		var totalPageNumber = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=getPlacesPage")!)
		totalPageNumber.httpMethod = "POST"
		let postString5="key=leuk12&secret=gammayz&sessionid=5bec8d79fad5448d59c4de4c93ad7e8b&token=ff478e0328eb7186dad1a42740375c0f82b80997b79390a177252bc7b21aa405"
		
		totalPageNumber.httpBody = postString5.data(using: .utf8)
		
		let task5 = URLSession.shared.dataTask(with: totalPageNumber) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				//print("GET TOTAL COUNT OF PAGES tab over --------------------")
				var json = JSON(data: data!)
				self.countOfPlaces =  json["response"]["data"][0]["total_count"].string!
				//print(self.countOfPlaces)
				//let a:Int? = countOfPlaces.

		      }
		}
		task5.resume()
		
		
		
		// MARK:- places api
		
		for i in 0..<40 {
		
		var places = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v19.php?method=getPlaces&pagecount=\(i)")!)
		places.httpMethod = "POST"
		let postString3="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
		
		
		places.httpBody = postString3.data(using: .utf8)
		
		let task4 = URLSession.shared.dataTask(with: mytickets) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				
				let responseString = String(data: data!, encoding: .utf8)
				print("responseString = \(responseString!)")
				print("GET Places tab over --------------------")
				var json = JSON(data: data!)
				let numberOfPlaces =  json["response"]["data"].count
				print(numberOfPlaces)
//				if numberOfPlaces > 0
//				{  for index in 0...numberOfPlaces-1 {
//					let a = homeOffers()
//					a.discountPercentage = json["response"]["data"][index]["offer_title"].string!
//					a.image = json["response"]["data"][index]["offer_image_link"].string!
//					a.left = json["response"]["data"][index]["coupon_credit_cost"].string!
//					a.title = json["response"]["data"][index]["offer_by"].string!
//					a.type = json["response"]["data"][index]["category"].string!
//					
//					if (a.type == "bars"){
//						homeOffersBars.append(a)
//					}else if (a.type == "apparels"){
//						homeOfferesApparels.append(a)
//					}else if (a.type == "fnb") {
//						homeOffersF_B.append(a)
//					}else if (a.type == "Hpy Hrs") {
//						homeOffersHappy.append(a)
//					}else if (a.type == "Sports") {
//						homeOffersSports.append(a)
//					}
//					
//					//else if (a.type == "") One left to add later
//					
//					
//					}}
				
			}
		}
		
		task4.resume()
		
		}
		
		
		
		
		
		
		
		
		
		
		
	}
	
	
	func getUserDetails(){
		
		if(sessionId != nil){
		
		
		var profileRequest = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v19.php?method=getUserInfo")!)
		profileRequest.httpMethod = "POST"
		let postString1="key=leuk12&secret=gammayz&sessionid=\(sessionId!)&token=\(tokenId!)"
		print("\(postString1)")
		
		
		profileRequest.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				print("response = \(response)")
			}
				
			else {
				//print("RFcss")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
				
				
				
				
//				var json = JSON(data: data!)
//				Name = json["response"]["data"]["name"].string!
//				area = json["response"]["data"]["location"].string!
//				referalCode = json["response"]["data"]["referral_code"].string!
//				level = json["response"]["data"]["level"].string!
//				profileImg = json["response"]["data"]["profile_img"].string!
//				totalCredits = json["response"]["data"]["total_credits"].string!
//				// remainingCredits = json["response"]["data"]["remaining_credits"].string!
//				print(Name)
			}
		}
		
		task2.resume()
		}

	}
	
	
	
	

	override func viewDidAppear(_ animated: Bool) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "launchdone1")
		self.present(controller, animated: true, completion: nil)
		
	}
	

	
	
    // MARK: - Navigation

	/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
	*/


}
