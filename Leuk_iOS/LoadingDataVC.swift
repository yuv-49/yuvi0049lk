//
//  LoadingDataVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Kingfisher

//import CoreLocation


class LoadingDataVC: UIViewController, CLLocationManagerDelegate {
	
//	var countOfPlaces: String!
//	var tokenIdFromGoogle: String!
//	var count: Int!
	
	
	
	let locationManager = CLLocationManager()

	
	
    override func viewDidLoad() {
	
	super.viewDidLoad()

	
	//MARK:- User Location
	
	getCurrentTime()

	removeAllValue()

	isAuthorizedtoGetUserLocation()
	
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest
	locationManager.requestAlwaysAuthorization()
	locationManager.startUpdatingLocation()
	
	
	

	
//	if CLLocationManager.locationServicesEnabled() {
//		
//		locationManager.requestLocation();
//	}

	
	
	
	countOfPagesForFirstPage = 0

	profileApi()
	getFeed()

	//////////////////firstpageNewsApi()
	
	getApi()
	getEventsValue()
	
	getPlacesValues()

	getTotalPageCount()
	getHomeBanners()
	
	
	
    }
	
	
	// MARK:- Location
	
	
	func isAuthorizedtoGetUserLocation() {
		
		if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		let status: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
		
		userLatitude = 28.4595
		userLongitude = 77.0266
		
		switch status {
		case .notDetermined:
			
			
			break
		// Do stuff
		case .authorizedAlways:
			
			
			break
		// Do stuff
		case .authorizedWhenInUse:
			
			let locValue:CLLocationCoordinate2D = manager.location!.coordinate
			userLatitude = locValue.latitude
			userLongitude = locValue.longitude
			print("locations = \(locValue.latitude) \(locValue.longitude)")
			
			break
			
		case .restricted:
			
			
			
			
			break
		// Do stuff
		case .denied:
			
			print("Denied")
			
			
			
			
			break
			// Do stuff
		}
		
		
		
		
		//		if status == .authorizedWhenInUse {
		//			print("User allowed us to access location")
		//			//do whatever init activities here.
		//
		//			let locValue:CLLocationCoordinate2D = manager.location!.coordinate
		//			userLatitude = locValue.latitude
		//			userLongitude = locValue.longitude
		//			print("locations = \(locValue.latitude) \(locValue.longitude)")
		//		}
	}
	
	
	

	
	
	
//	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//		let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//		print("locations = \(locValue.latitude) \(locValue.longitude)")
//	}
	
//	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//		if status == .authorizedAlways {
//			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
//				if CLLocationManager.isRangingAvailable() {
//					
//					let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//					print("locations = \(locValue.latitude) \(locValue.longitude)")
//				}
//			}
//		}
//	}
	
	//MARK:- time function
	
	
	func getCurrentTime(){
		
		
		
		let date = Date()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "HH:mm"
		let string = dateFormatter.string(from: date as Date)
		
		
		var photoLinkArray = string.characters.split{$0 == ":"}.map(String.init)
		currentHour = photoLinkArray[0]
		print("hahahsd \(currentHour)")
		
		
	}
	
	
	//MARK:- Feed values
	
	func getFeed(){
		
		var feedRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getiOSFeed")!)
		feedRequest.httpMethod = "POST"
		let postStringForFeeds="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postStringForFeeds)")
		
		
		feedRequest.httpBody = postStringForFeeds.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: feedRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				homeFeed.removeAll()
				
				
				
				var json = JSON(data: data!)
				print(json)
				let numberOfEvents =  json["response"]["data"].count
				countOfPagesForFirstPage = numberOfEvents
				
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						let getFeedArray = Feeds()
						getFeedArray.id = json["response"]["data"][index]["id"].string!
						getFeedArray.title = json["response"]["data"][index]["title"].string!
						getFeedArray.type = json["response"]["data"][index]["type"].string!
						getFeedArray.tags = json["response"]["data"][index]["tags"].string!
						getFeedArray.parameters = json["response"]["data"][index]["parameters"].string!
						getFeedArray.gender = json["response"]["data"][index]["gender"].string!
						getFeedArray.time = json["response"]["data"][index]["time"].string!
						getFeedArray.day = json["response"]["data"][index]["day"].string!
						getFeedArray.priority = json["response"]["data"][index]["priority"].string!
						getFeedArray.status = json["response"]["data"][index]["status"].string!
						
						if currentHour < "11" {
							if getFeedArray.time == "1" || getFeedArray.time == "6"{
								homeFeed.append(getFeedArray)
								print("ht \(getFeedArray.id)")
							}
						}else if currentHour > "11" && currentHour < "18" {
							if getFeedArray.time == "2" || getFeedArray.time == "6"{
								homeFeed.append(getFeedArray)
								print("ht \(getFeedArray.id)")

							}
						}else if currentHour > "18" && currentHour < "21" {
							if getFeedArray.time == "3" || getFeedArray.time == "6"{
								homeFeed.append(getFeedArray)
								print("ht \(getFeedArray.id)")

							}
						}else if currentHour > "21" && currentHour < "4" {
							if getFeedArray.time == "4" {
								homeFeed.append(getFeedArray)
								print("ht \(getFeedArray.id)")

							}
						}else if currentHour > "23" && currentHour < "1" {
							if getFeedArray.time == "5" {
								homeFeed.append(getFeedArray)
								print("ht \(getFeedArray.id)")

							}
							
				
							
						}
						
						// Code here..
						
						let noOfEvents = json["response"]["data"][index]["inner_data"].count
						
						print("hpy \(noOfEvents)")
						if noOfEvents > 1 {

							
								
								if getFeedArray.type == "1" {
									
									for indexVal in 0...noOfEvents-1
									{
									
									let placesValue = Places()
									placesValue.placeId = json["response"]["data"][index]["inner_data"][indexVal]["id"].string!
									placesValue.placeName = json["response"]["data"][index]["inner_data"][indexVal]["name"].string!
									placesValue.placeType = json["response"]["data"][index]["inner_data"][indexVal]["type"].string!
									placesValue.latFinal = json["response"]["data"][index]["inner_data"][indexVal]["latitude"].string!
									placesValue.longFinal = json["response"]["data"][index]["inner_data"][indexVal]["longitude"].string!
									placesValue.placeRating = json["response"]["data"][index]["inner_data"][indexVal]["rating"].string!
									placesValue.placeDescription = json["response"]["data"][index]["inner_data"][indexVal]["description"].string!
									placesValue.placeAddress = json["response"]["data"][index]["inner_data"][indexVal]["address"].string!
									placesValue.placeArea = json["response"]["data"][index]["inner_data"][indexVal]["location"].string!
									placesValue.placeImageFullLink = json["response"]["data"][index]["inner_data"][indexVal]["photo_link"].string!
									placesValue.mapURL = json["response"]["data"][index]["inner_data"][indexVal]["maps_url"].string!
									placesValue.lastUpdate = json["response"]["data"][index]["inner_data"][indexVal]["last_update"].string!
									
									placesValue.featured = json["response"]["data"][index]["inner_data"][indexVal]["featured"].string!
									placesValue.recommended = json["response"]["data"][index]["inner_data"][indexVal]["recommended"].string!
									
									var openingTime = json["response"]["data"][index]["inner_data"][indexVal]["opening_hour"].string!
									var closingTime = json["response"]["data"][index]["inner_data"][indexVal]["closing_hour"].string!
									
									var openingTimeFInal = openingTime.characters.split{$0 == ":"}.map(String.init)
									var closingTimeFinal = closingTime.characters.split{$0 == ":"}.map(String.init)
									if openingTimeFInal.count != 0 && closingTimeFinal.count != 0 {
										
										placesValue.openingTimeHour = openingTimeFInal[0]
										
										placesValue.openingTimeMinute = "00"
										placesValue.closingTimeHour = closingTimeFinal[0]
										placesValue.closingTimeMinute = "00"
									}
									
									placesValue.service = json["response"]["data"][index]["inner_data"][indexVal]["service"].string!
									placesValue.orderType = json["response"]["data"][index]["inner_data"][indexVal]["order_type"].string!
									
									placesValue.views = json["response"]["data"][index]["inner_data"][indexVal]["views"].string!
									
									
									
									if(placesValue.placeRating == ""){
										placesValue.placeRating = "3.0"
									}
									
									placesValue.photoLink = json["response"]["data"][index]["inner_data"][indexVal]["photo_link"].string!
									
									
									getFeedArray.placeParam.append(placesValue)
									
									
									}
									
									
									
									
								}else if getFeedArray.type == "2" {
									
									
									for indexVal in 0...noOfEvents-1
									{
										
										let eventValuesArray = homeEvents()
										
										eventValuesArray.eventId = json["response"]["data"][index]["inner_data"][indexVal]["id"].string!
										eventValuesArray.eventLogo = json["response"]["data"][index]["inner_data"][indexVal]["logo"].string!
										eventValuesArray.eventName = json["response"]["data"][index]["inner_data"][indexVal]["name"].string!
										eventValuesArray.eventHostedBy = json["response"]["data"][index]["inner_data"][indexVal]["hosted_by"].string!
										eventValuesArray.eventCategory = json["response"]["data"][index]["inner_data"][indexVal]["category"].string!
										eventValuesArray.eventDate = json["response"]["data"][index]["inner_data"][indexVal]["date"].string!
										eventValuesArray.eventTime = json["response"]["data"][index]["inner_data"][indexVal]["time"].string!
										eventValuesArray.eventImageLink = json["response"]["data"][index]["inner_data"][indexVal]["image_link"].string!
										
										eventValuesArray.eventTicketBasecode = json["response"]["data"][index]["inner_data"][indexVal]["ticket_basecode"].string!
										
										
										eventValuesArray.eventDesc = json["response"]["data"][index]["inner_data"][indexVal]["description"].string!
										eventValuesArray.eventFee = json["response"]["data"][index]["inner_data"][indexVal]["fee"].string!
										eventValuesArray.eventPhoneNumber = json["response"]["data"][index]["inner_data"][indexVal]["phone"].string!
										eventValuesArray.eventAddress = json["response"]["data"][index]["inner_data"][indexVal]["address"].string!
										eventValuesArray.eventLat = json["response"]["data"][index]["inner_data"][indexVal]["latitude"].string!
										eventValuesArray.eventLong = json["response"]["data"][index]["inner_data"][indexVal]["longitude"].string!
										eventValuesArray.eventSingleLimit = json["response"]["data"][index]["inner_data"][indexVal]["individual_ticket_limit"].string!
										eventValuesArray.eventTicketSales = json["response"]["data"][index]["inner_data"][indexVal]["ticket_sales"].string!
										eventValuesArray.eventTicketLimit = json["response"]["data"][index]["inner_data"][indexVal]["ticket_limit"].string!
										eventValuesArray.eventWebsite = json["response"]["data"][index]["inner_data"][indexVal]["website"].string!
										
										eventValuesArray.recommended = json["response"]["data"][index]["inner_data"][indexVal]["recommended"].string!
										
										eventValuesArray.views = json["response"]["data"][index]["inner_data"][indexVal]["views"].string!
										
										
										getFeedArray.eventParam.append(eventValuesArray)
									}
									
									
									
									
									
								}else if getFeedArray.type == "3"{
									
									for indexVal in 0...noOfEvents-1
									{
										
										let offerValue = HomeOffers()
										offerValue.offerDiscount = json["response"]["data"][index]["inner_data"][indexVal]["offer_title"].string!
										offerValue.offerImage = json["response"]["data"][index]["inner_data"][indexVal]["offer_image_link"].string!
										offerValue.offerBy = json["response"]["data"][index]["inner_data"][indexVal]["offer_by"].string!
										offerValue.offerCategory = json["response"]["data"][index]["inner_data"][indexVal]["category"].string!
										offerValue.offerDeal = json["response"]["data"][index]["inner_data"][indexVal]["coupon_basecode"].string!
										offerValue.offerById = json["response"]["data"][index]["inner_data"][indexVal]["offer_by_id"].string!
										offerValue.offerDesc = json["response"]["data"][index]["inner_data"][indexVal]["offer_desc"].string!
										offerValue.offerExpiry = json["response"]["data"][index]["inner_data"][indexVal]["offer_expiry"].string!
										offerValue.offerTiming = json["response"]["data"][index]["inner_data"][indexVal]["offer_time"].string!
										offerValue.offerTitle = json["response"]["data"][index]["inner_data"][indexVal]["offer_title"].string!
										offerValue.recommended = json["response"]["data"][index]["inner_data"][indexVal]["recommended"].string!
										
										
										getFeedArray.offerParam.append(offerValue)
										
										
										
									}
									
								}
							
							}
							
						

						
						
						
						

						
						

						
						
						
						
						
						
					}
				}
			}
			
			
			
		}
		
		
		
		task2.resume()
	}
	
	//MARK:- HomeBanners
	
	func getHomeBanners(){
		
		
		
		var bannerRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getHomeBanner")!)
		bannerRequest.httpMethod = "POST"
		let postStringForBanners="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postStringForBanners)")
		
		
		bannerRequest.httpBody = postStringForBanners.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: bannerRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				homeBanners.removeAll()
				
				
				
				var json = JSON(data: data!)
				let numberOfEvents =  json["response"]["data"].count
				//print("Yhapy \(numberOfEvents)")
				//DispatchQueue.main.async {
				countOfPagesForFirstPage = numberOfEvents
				//}
				
				
				
			//	print(numberOfEvents)
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						let getBannerArray = Banners()
						getBannerArray.id = json["response"]["data"][index]["id"].string!
						getBannerArray.image = json["response"]["data"][index]["image"].string!
						getBannerArray.url = json["response"]["data"][index]["url"].string!
						getBannerArray.type = json["response"]["data"][index]["type"].string!
						getBannerArray.kind = json["response"]["data"][index]["kind"].string!
						getBannerArray.keyParam = json["response"]["data"][index]["key_param"].string!
						getBannerArray.displayDate = json["response"]["data"][index]["display_on_day"].string!
						getBannerArray.location = json["response"]["data"][index]["location"].string!
						getBannerArray.views = json["response"]["data"][index]["views"].string!
						getBannerArray.status = json["response"]["data"][index]["status"].string!

						
						homeBanners.append(getBannerArray)
						
						
						

						
						
					}
				}
			}
			
			
			
		}
		
		
		
		task2.resume()
		
		
		
	}
	
	
	func firstpageNewsApi(){
		
		
		
		//MARK:- FIRST PAGE NEWS
		
		var newsRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getPlaceNews")!)
		newsRequest.httpMethod = "POST"
		let postStringForNews="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postStringForNews)")
		
		
		newsRequest.httpBody = postStringForNews.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: newsRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				firstPageNews.removeAll()

				
				
				var json = JSON(data: data!)
				let numberOfEvents =  json["response"]["data"].count
				
				//DispatchQueue.main.async {
					countOfPagesForFirstPage = numberOfEvents
				//}
				
				
				
				print(numberOfEvents)
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						let getNewsArray = PopularNews()
						
						getNewsArray.newsId = json["response"]["data"][index]["id"].string!
						getNewsArray.imageLink = json["response"]["data"][index]["image_link"].string!
						getNewsArray.newsTitle = json["response"]["data"][index]["news_title"].string!
						getNewsArray.hits = json["response"]["data"][index]["hits"].string!
						getNewsArray.newsSource = json["response"]["data"][index]["source"].string!
						getNewsArray.pageLink = json["response"]["data"][index]["link"].string!
						
						
						
						
						firstPageNews.append(getNewsArray)
						
						
					}
				}
			}
			
			
			
		}
		
		
		
		task2.resume()
		
	}

	
	
	
	
	
	
	
	
	func profileApi(){
		
		
		//MARK:- PROFILE
		
		var profileRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getUserInfo")!)
		profileRequest.httpMethod = "POST"
		let postString1="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postString1)")
		
		
		profileRequest.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				var json = JSON(data: data!)
				Name = json["response"]["data"]["name"].string!
				area = json["response"]["data"]["location"].string!
				referalCode = json["response"]["data"]["referral_code"].string!
				level = json["response"]["data"]["level"].string!
				profileImages = json["response"]["data"]["profile_img"].string!
				totalCredits = json["response"]["data"]["total_credits"].string!
				remainingCredits = json["response"]["data"]["remaining_credits"].string!
				print("area \(area)")
			}
		}
		
		task2.resume()
		
		
	}
	
	
	
	
	func getTotalPageCount(){
		
		
		
		//MARK:- total places count
		
		
		
		
		var totalPageNumber = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getPlacesPage")!)
		totalPageNumber.httpMethod = "POST"
		let postString5="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		
		totalPageNumber.httpBody = postString5.data(using: .utf8)
		
		let task5 = URLSession.shared.dataTask(with: totalPageNumber) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				var json = JSON(data: data!)
				//print("hsuhu \(json)")
				//print()
				placesPagesCount =  json["response"]["data"][0]["total_page_count"].int!
				
				//print("total \(countOfPlaces)")
				
				//self.getPlacesValues()

				
				

				
			}
		}
		task5.resume()
		

	}
	
	
	
	
	func getPlacesValues(){
		
		
		
		
		//call for the rest of pages with value placesPagesCount in any other place than this
		
		
		// MARK:- places api

		
		
		for values in 1...5{
			
			//print("HEREEEEEEEE")
		
			var places = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getPlaces")!)
			places.httpMethod = "POST"
			let postString3="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&page=\(values)"
			
			
			places.httpBody = postString3.data(using: .utf8)
			
			let task4 = URLSession.shared.dataTask(with: places) { data, response, error in
				if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
					print("statusCode should be 200, but is \(httpStatus.statusCode)")
					//print("response = \(response)")
				}
					
				else {
					

					var json = JSON(data: data!)
					let numberOfPlaces =  json["response"]["data"].count
					//print(" haps \(json["response"]["data"])")
					//print("ha \(numberOfPlaces)")
					if numberOfPlaces > 0
					{
						for index in 0...numberOfPlaces-1 {
							
							let placesValue = Places()
							placesValue.placeId = json["response"]["data"][index]["id"].string!
							placesValue.placeName = json["response"]["data"][index]["name"].string!
							placesValue.placeType = json["response"]["data"][index]["type"].string!
							placesValue.latFinal = json["response"]["data"][index]["latitude"].string!
							placesValue.longFinal = json["response"]["data"][index]["longitude"].string!
							placesValue.phoneNumber = json["response"]["data"][index]["phone"].string!
							placesValue.placeRating = json["response"]["data"][index]["rating"].string!
							placesValue.placeDescription = json["response"]["data"][index]["description"].string!
							placesValue.placeAddress = json["response"]["data"][index]["address"].string!
							placesValue.placeArea = json["response"]["data"][index]["location"].string!
							placesValue.placeImageFullLink = json["response"]["data"][index]["photo_link"].string!
							placesValue.mapURL = json["response"]["data"][index]["maps_url"].string!
							placesValue.lastUpdate = json["response"]["data"][index]["last_update"].string!
							
							placesValue.featured = json["response"]["data"][index]["featured"].string!
							placesValue.recommended = json["response"]["data"][index]["recommended"].string!
							
							var openingTime = json["response"]["data"][index]["opening_hour"].string!
							var closingTime = json["response"]["data"][index]["closing_hour"].string!
							
						      var openingTimeFInal = openingTime.characters.split{$0 == ":"}.map(String.init)
							var closingTimeFinal = closingTime.characters.split{$0 == ":"}.map(String.init)
							if openingTimeFInal.count != 0 && closingTimeFinal.count != 0 {
							
							placesValue.openingTimeHour = openingTimeFInal[0]
							
							placesValue.openingTimeMinute = "00"
							placesValue.closingTimeHour = closingTimeFinal[0]
							placesValue.closingTimeMinute = "00"
							}
							
							placesValue.service = json["response"]["data"][index]["service"].string!
							placesValue.orderType = json["response"]["data"][index]["order_type"].string!
							
							placesValue.views = json["response"]["data"][index]["views"].string!
							
							
							
							if(placesValue.placeRating == ""){
								placesValue.placeRating = "3.0"
							}
							
							placesValue.photoLink = json["response"]["data"][index]["photo_link"].string!
							
					

							var photoLinkArray = placesValue.photoLink.characters.split{$0 == ","}.map(String.init)
//							if (photoLinkArray.count) > 0 {
//
//								placesValue.placeFirstImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/DelhiNCR/\(placesValue.placeId ?? "")/\(photoLinkArray[0] ).png")!
//								print("Img \(placesValue.placeFirstImageUrl)")
//
//								
//
//
//							}
//							if (photoLinkArray.count) > 1 {
//
//								placesValue.placeSecondImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/DelhiNCR/\(placesValue.placeId ?? "")/\(photoLinkArray[1] ).png")!
//
//								print("Img \(placesValue.placeFirstImageUrl)")
//
//
//
//
//							}
							
							//print("Add \(valueForPlaces[indexPath.row].placeFirstImageUrl)")

							
							
							
				//MARK:- location Places
							
							
							
//							userLatitude = 28.4595
//							userLongitude = 77.0266
							
							
							
//							if let d = Float(lat) {
//								if let e = Float(long) {
//									let coordinate1 = CLLocation(latitude: CLLocationDegrees(d),longitude: CLLocationDegrees(e))
//									let coordinate2 = CLLocation(latitude: userLatitude,longitude: userLongitude)
//									let distanceInMetres = coordinate1.distance(from: coordinate2)
//									
//									var V = Float(distanceInMetres)
//									if(distanceInMetres <= 1000){
//										
//										placesValue.placeDistance = "\(V)"+" metres"
//									}else {
//										V /= 1000
//										placesValue.placeDistance = "\(V)"+" KM"
//									}
//									
//									
//									
//								}
//							}
						
							
// MARK:- Order Now
// get a view later for the identifier
							
					
							
							if (placesValue.service == "1"){
								
								if placesValue.recommended == "1" {
									
									pageOneValues.append(placesValue)
								}
								
								
								
								
								if(placesValue.orderType == "Grocery"){
									GroceriesOrder.append(placesValue)
								}
								else if(placesValue.orderType == "Restaurant"){
									restaurantOrder.append(placesValue)
								}
								else if(placesValue.orderType == "Medicine"){
									MedicineOrder.append(placesValue)
								}
								else if(placesValue.orderType == "Stationary"){
									staitionaryOrder.append(placesValue)
								}

							}
							
							
					
							
							
				       if (placesValue.placeType == "restaurant") {
						
						if placesValue.recommended == "1" {
							
							pageFourValues.append(placesValue)
						}

						
						if(self.checkValue(idValue: placesValue.placeId, arrayName: restaurantValues)){
							restaurantValues.append(placesValue)

						}
					}
					else if (placesValue.placeType == "store") {
						
						if placesValue.recommended == "1" {
							
							pageFourValues.append(placesValue)
						}
						
						if(self.checkValue(idValue: placesValue.placeId, arrayName: storesValues)){
							storesValues.append(placesValue)
						}
					}
					else if (placesValue.placeType == "pubs") {
						
						
						if placesValue.recommended == "1" {
							pageFourValues.append(placesValue)
						}
						
						
						if(self.checkValue(idValue: placesValue.placeId, arrayName: pubsValues)){
							pubsValues.append(placesValue)

						}
					}
					else if (placesValue.placeType == "entertainment") {
						
						if placesValue.recommended == "1" {
							
							pageFourValues.append(placesValue)
						}
						
						
						if(self.checkValue(idValue: placesValue.placeId, arrayName: EntertainmentValues)){
							EntertainmentValues.append(placesValue)
						}
					}
					else if (placesValue.placeType == "cafe") {
						
						if placesValue.recommended == "1" {
							
							pageFourValues.append(placesValue)
						}
						
						
							if(self.checkValue(idValue: placesValue.placeId, arrayName: cafeValues)){
								cafeValues.append(placesValue)
						}
					}
					else if (placesValue.placeType == "medical") {
						
						if placesValue.recommended == "1" {
							
							pageFourValues.append(placesValue)
						}
						
						
								if(self.checkValue(idValue: placesValue.placeId, arrayName: MedicalValues)){
									MedicalValues.append(placesValue)
						}
					  }
							
						}
					}
					
				}
			}
			
			task4.resume()
		}
		
		}
		
		

		
	
	func checkValue(idValue: String,arrayName array: [Places])-> Bool
	{
		for i in 0..<array.count{
			if array[i].placeId == idValue{
				return false
			}
		}
		return true
		
	}
	
	
	
	
	func getEventsValue(){
		
		var eventRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getEvents")!)
		eventRequest.httpMethod = "POST"
		let postStringForEvents="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postStringForEvents)")
		
		
		eventRequest.httpBody = postStringForEvents.data(using: .utf8)
		
		let taskForEvents = URLSession.shared.dataTask(with: eventRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				var json = JSON(data: data!)
				let numberOfEvents =  json["response"]["data"].count
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
				
						let eventValuesArray = homeEvents()
				
						eventValuesArray.eventId = json["response"]["data"][index]["id"].string!
						eventValuesArray.eventLogo = json["response"]["data"][index]["logo"].string!
						eventValuesArray.eventName = json["response"]["data"][index]["name"].string!
						eventValuesArray.eventHostedBy = json["response"]["data"][index]["hosted_by"].string!
						eventValuesArray.eventCategory = json["response"]["data"][index]["category"].string!
						eventValuesArray.eventDate = json["response"]["data"][index]["date"].string!
						eventValuesArray.eventTime = json["response"]["data"][index]["time"].string!
						eventValuesArray.eventImageLink = json["response"]["data"][index]["image_link"].string!

						eventValuesArray.eventTicketBasecode = json["response"]["data"][index]["ticket_basecode"].string!


						eventValuesArray.eventDesc = json["response"]["data"][index]["description"].string!
						eventValuesArray.eventFee = json["response"]["data"][index]["fee"].string!
						eventValuesArray.eventPhoneNumber = json["response"]["data"][index]["phone"].string!
						eventValuesArray.eventAddress = json["response"]["data"][index]["address"].string!
						eventValuesArray.eventLat = json["response"]["data"][index]["latitude"].string!
						eventValuesArray.eventLong = json["response"]["data"][index]["longitude"].string!
						eventValuesArray.eventSingleLimit = json["response"]["data"][index]["individual_ticket_limit"].string!
						eventValuesArray.eventTicketSales = json["response"]["data"][index]["ticket_sales"].string!
						eventValuesArray.eventTicketLimit = json["response"]["data"][index]["ticket_limit"].string!
						eventValuesArray.eventWebsite = json["response"]["data"][index]["website"].string!
					
						eventValuesArray.recommended = json["response"]["data"][index]["recommended"].string!
						
						eventValuesArray.views = json["response"]["data"][index]["views"].string!
						
						if eventValuesArray.recommended == "1" {
							
							pageThreeValues.append(eventValuesArray)
						}
						
						
						
						
						
						if (eventValuesArray.eventCategory == "Social") {
							socialValues.append(eventValuesArray)
						}else if eventValuesArray.eventCategory == "Food" {
							foodValues.append(eventValuesArray)
						}else if eventValuesArray.eventCategory == "Party" {
							
							partyValues.append(eventValuesArray)
//						}else if eventValuesArray.eventCategory == "Comedy" {
//							partyValues.append(eventValuesArray)
						}else if eventValuesArray.eventCategory == "Startup" {
							startupValues.append(eventValuesArray)
						}else if eventValuesArray.eventCategory == "Sports" {
							sportsValues.append(eventValuesArray)
						}
						
						
						
	//MARK:- events to add later
       //MARK:- must do...
						
						
						
						
						

						
					}
				}
			}
					
					
					
		}
		
		taskForEvents.resume()

		
	}
	
	
	
	
	
	
	
	
	
	func getApi(){
		

		
		
		
//		 MARK:- get offers
		
		
		
		
		var mytickets = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getOffers")!)
		mytickets.httpMethod = "POST"
		let postString2="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		
		
		mytickets.httpBody = postString2.data(using: .utf8)
		
		let task3 = URLSession.shared.dataTask(with: mytickets) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
		
				var json = JSON(data: data!)
				
				let numberOfPlaces =  json["response"]["data"].count
				print("ll \(numberOfPlaces)")
				if numberOfPlaces > 0
				{  for index in 0...numberOfPlaces-1 {
					let offerValue = HomeOffers()
					offerValue.offerDiscount = json["response"]["data"][index]["offer_title"].string!
					offerValue.offerImage = json["response"]["data"][index]["offer_image_link"].string!
					offerValue.offerBy = json["response"]["data"][index]["offer_by"].string!
					offerValue.offerCategory = json["response"]["data"][index]["category"].string!
					offerValue.offerDeal = json["response"]["data"][index]["coupon_basecode"].string!
					offerValue.offerById = json["response"]["data"][index]["offer_by_id"].string!
					offerValue.offerDesc = json["response"]["data"][index]["offer_desc"].string!
					offerValue.offerExpiry = json["response"]["data"][index]["offer_expiry"].string!  
					offerValue.offerTiming = json["response"]["data"][index]["offer_time"].string!
					offerValue.offerTitle = json["response"]["data"][index]["offer_title"].string!
					offerValue.recommended = json["response"]["data"][index]["recommended"].string!
					
					
					if offerValue.recommended == "1"{
					
						pageTwoValues.append(offerValue)
					}
// add views
					
					if (offerValue.offerCategory == "bars"){
						homeOffersBars.append(offerValue)
					}else if (offerValue.offerCategory == "Apparels"){
						homeOfferesApparels.append(offerValue)
					}else if (offerValue.offerCategory == "fnb") {
						homeOffersF_B.append(offerValue)
					}else if (offerValue.offerCategory == "Hpy Hrs") {
						print("haufhd pubs")

						homeOffersHappy.append(offerValue)
					}else if (offerValue.offerCategory == "Sports") {
						homeOffersSports.append(offerValue)
					}else if (offerValue.offerCategory == "Pubs") {
						homeOffersBars.append(offerValue)
					}
					
					//else if (a.type == "") one left to add later
					

					
					}
				}
				
			}
		}
		
		task3.resume()
		
		
		
		
		
		

		
		
		
		
		
		
	}
	
	
//	func getUserDetails(){
//		
//		if(sessionId != nil){
//		
//		
//		var profileRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getUserInfo")!)
//		profileRequest.httpMethod = "POST"
//		let postString1="key=leuk12&secret=gammayz&sessionid=\(sessionId!)&token=\(tokenId!)"
//		print("\(postString1)")
//		
//		
//		profileRequest.httpBody = postString1.data(using: .utf8)
//		
//		let task6 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
//			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//				print("statusCode should be 200, but is \(httpStatus.statusCode)")
//				//print("response = \(response)")
//			}
//				
//			else {
//				//print("RFcss")
//				//let responseString = String(data: data!, encoding: .utf8)
//				//print("responseString = \(responseString!)")
//				
//				
//				
//				
//				
////				var json = JSON(data: data!)
////				Name = json["response"]["data"]["name"].string!
////				area = json["response"]["data"]["location"].string!
////				referalCode = json["response"]["data"]["referral_code"].string!
////				level = json["response"]["data"]["level"].string!
////				profileImg = json["response"]["data"]["profile_img"].string!
////				totalCredits = json["response"]["data"]["total_credits"].string!
////				// remainingCredits = json["response"]["data"]["remaining_credits"].string!
////				print(Name)
//			}
//		}
//		
//		task6.resume()
//		}
//		
//
//	}
	
	
	
	

	override func viewDidAppear(_ animated: Bool) {
		
		
		//restaurantOrder.removeAll()
		
		checkConnection()
		
		
		getSessionAndToken()

		//update()
		
		
		_ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false);

		
		
		
		
		
//		//All network operations has to run on different thread(not on main thread).
//		DispatchQueue.global(qos: .userInitiated).async {
//			
//			self.firstpageNewsApiCall()
//			//All UI operations has to run on main thread.
//			DispatchQueue.main.async {
//				
//				var timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: false);
//			}
//		}
//		
		
		
		
		
		
		
		
	}
	func checkConnection(){
		
		if Reachability.isConnectedToNetwork() == true
		{
			print("Internet Connection Available!")
		}
		else
		{
			
			let alertController = UIAlertController(title: "Internet Connection Not Available", message: "Please connect to Internet", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				//print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			//UIAlertView.init(title: "Internet Connection Not Available", message: "Please connect to Internet", delegate: self, cancelButtonTitle: "OK").show()
			
			print("Internet Connection not Available!")
		}
	}
	
	
	
	func removeAllValue(){
		
		
		restaurantValues.removeAll()
		storesValues.removeAll()
		pubsValues.removeAll()
		EntertainmentValues.removeAll()
	       cafeValues.removeAll()
		MedicalValues.removeAll()
		
		
		
		
		restaurantOrder.removeAll()
		GroceriesOrder.removeAll()
		MedicineOrder.removeAll()
		staitionaryOrder.removeAll()
		
		
		
		pageOneValues.removeAll()
		pageFourValues.removeAll()
		pageTwoValues.removeAll()
		pageThreeValues.removeAll()
		
		
		
		foodValues.removeAll()
		socialValues.removeAll()
		startupValues.removeAll()
		sportsValues.removeAll()
		meetupValues.removeAll()
		partyValues.removeAll()
		
		
		homeOffersBars.removeAll()
		homeOffersF_B.removeAll()
		homeOfferesApparels.removeAll()
		homeOffersHappy.removeAll()
		homeOffersSports.removeAll()
		homeOffersSpa.removeAll()
		
		
	}
	
	
	func getSessionAndToken(){
		
		if let SessionIdForSaving = userDefaults.value(forKey: "SessionIdForSaving") {
			SESSION_ID = (SessionIdForSaving as? String)!
		}
		
		if let tokenIdForSaving = userDefaults.value(forKey: "tokenIdForSaving") {
			TOKEN_ID_FROM_LEUK = (tokenIdForSaving as? String)!
		}
		
		
		
		
	}
	
	func update() {
		

		
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "launchdone1")
		self.present(controller, animated: true, completion: nil)
		
		
		
		
		
			}
	
	
	
	func firstpageNewsApiCall(){
		
		
		
		//MARK:- FIRST PAGE NEWS
		
		var newsRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getPopularNews")!)
		newsRequest.httpMethod = "POST"
		let postStringForNews="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID)&token=\(TOKEN_ID_FROM_LEUK)"
		print("\(postStringForNews)")
		
		
		newsRequest.httpBody = postStringForNews.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: newsRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				
				
				
				
				var json = JSON(data: data!)
				let numberOfEvents =  json["response"]["data"].count
				print(numberOfEvents)
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						let getNewsArray = PopularNews()
						
						getNewsArray.newsId = json["response"]["data"][index]["id"].string!
						print(getNewsArray.newsId)
						getNewsArray.imageLink = json["response"]["data"][index]["image_link"].string!
						getNewsArray.newsTitle = json["response"]["data"][index]["source"].string!
						getNewsArray.hits = json["response"]["data"][index]["hits"].string!
						
						if let strImage = getNewsArray.imageLink {
							
							
							if let data = NSData(contentsOf: NSURL(string:strImage )! as URL) {
								getNewsArray.imageLinkOriginal = UIImage(data: data as Data)
							}
						}
						
						
						
						firstPageNews.append(getNewsArray)
						
						
					}
				}
			}
			
			
			
		}
		
		
		
		task2.resume()
		
		
		
		
		
		
	}
	

	
	
	
	
    // MARK: - Navigation

	/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
	*/


}
