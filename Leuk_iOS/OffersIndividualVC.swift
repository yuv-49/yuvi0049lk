//
//  OffersIndividualVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 07/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class OffersIndividualVC: UIViewController {
	
	
	@IBOutlet weak var offerPlaceImage: UIImageView!
	@IBOutlet weak var offerPlaceName: UILabel!
	@IBOutlet weak var offerPlaceLogo: UIImageView!
	@IBOutlet weak var offerPlaceDistance: UILabel!
	@IBOutlet weak var offerTiming: UILabel!
	@IBOutlet weak var offerExpiry: UILabel!
	@IBOutlet weak var offerDesc: UILabel!
	@IBOutlet weak var offerTitle: UILabel!
	@IBOutlet weak var offerImage: UIImageView!
	
	@IBOutlet weak var purchaseOrContact: UIButton!
	
	var homeOfferReceived = HomeOffers()
	var purchaseOrContactValue: Int!
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
	

	
	//print("\(homeOfferReceived.offerBy)")
	
	offerPlaceName.text = homeOfferReceived.offerBy
	offerTitle.text = homeOfferReceived.offerTitle
	offerDesc.text = homeOfferReceived.offerDesc
	offerExpiry.text = homeOfferReceived.offerExpiry
	
	getPurchaseCommand()
	
	
//	
//	if let val = placeTransitionArray.placeFirstImageUrl {
//		
//
//		offerPlaceImage.kf.setImage(with: val)
//	}
	
	purchaseOrContactValue = 0
	
	let url = URL(string: homeOfferReceived.offerImage)
	offerImage.kf.setImage(with: url)
	offerTiming.text = homeOfferReceived.offerTiming
	
	
	}
	
	
	func getPurchaseCommand(){
		
		if homeOfferReceived.offerDeal == "DEAL" {
			purchaseOrContact.setTitle("CONTACT STORE", for: .normal)
			purchaseOrContactValue = 1
		}else{
			purchaseOrContact.setTitle("PURCHASE COUPON", for: .normal)
			purchaseOrContactValue = 2
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	@IBAction func viewPlace(_ sender: Any) {
		
		offerToPlaceTransition = 1
		
		//getPlaceInfoById()
		
		DispatchQueue.main.async {
			self.performSegue(withIdentifier: "viewplace", sender: self)
			
		}
		
		
	}
	
	
	
	

















	func getPlaceInfoById(){
		
		
		//MARK:- PLACEBYID
		
		
		var placeReq = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getPlacebyId")!)
		placeReq.httpMethod = "POST"
		let postString="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&place_id=\(homeOfferReceived.offerById!)"
		print("\(postString)")
		
		
		placeReq.httpBody = postString.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: placeReq) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				
				
				
				
				let json = JSON(data: data!)
				print("hahaha ksa \(json)")
				let index = 0
		

				
				
				placeTransitionArray.placeId = json["response"]["data"][index]["id"].string!
				placeTransitionArray.placeName = json["response"]["data"][index]["name"].string!
				placeTransitionArray.placeType = json["response"]["data"][index]["type"].string!
				placeTransitionArray.latFinal = json["response"]["data"][index]["latitude"].string!
				placeTransitionArray.longFinal = json["response"]["data"][index]["longitude"].string!
				placeTransitionArray.phoneNumber = json["response"]["data"][index]["phone"].string!
				placeTransitionArray.placeRating = json["response"]["data"][index]["rating"].string!
				placeTransitionArray.placeDescription = json["response"]["data"][index]["description"].string!
				placeTransitionArray.placeAddress = json["response"]["data"][index]["address"].string!
				placeTransitionArray.mapURL = json["response"]["data"][index]["maps_url"].string!
				placeTransitionArray.placeType = json["response"]["data"][index]["type"].string!
				
//				
//				if self.purchaseOrContactValue == 0 {
//					self.getPurchaseCommand()
//				}
				

				
				
				
				
				
				if(placeTransitionArray.placeRating == ""){
					placeTransitionArray.placeRating = "3.0"
				}
				
				placeTransitionArray.photoLink = json["response"]["data"][index]["photo_link"].string!
				
				
				
				var photoLinkArray = placeTransitionArray.photoLink.characters.split{$0 == ","}.map(String.init)
				if (photoLinkArray.count) > 0 {
					
					placeTransitionArray.placeFirstImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/DelhiNCR/\(placeTransitionArray.placeId ?? "")/\(photoLinkArray[0] ).png")!
					print("htrnvm \(placeTransitionArray.placeFirstImageUrl)")
//MARK:- set the place image
					
					self.offerPlaceLogo.kf.setImage(with: placeTransitionArray.placeFirstImageUrl)
					
					
				}
				if (photoLinkArray.count) > 1 {
					
					placeTransitionArray.placeSecondImageUrl =  URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(placeTransitionArray.placeId ?? "")/\(photoLinkArray[1] ).png")!
					
					
					
					
				}
				
				      self.offerPlaceImage.kf.setImage(with: placeTransitionArray.placeSecondImageUrl)
				
				
				
				
				
				
				
//				userLatitude = 28.4595
//				userLongitude = 77.0266
				
				
				
				if let d = Float(placeTransitionArray.latFinal) {
					if let e = Float(placeTransitionArray.longFinal) {
						let coordinate1 = CLLocation(latitude: CLLocationDegrees(d),longitude: CLLocationDegrees(e))
						let coordinate2 = CLLocation(latitude: userLatitude,longitude: userLongitude)
						let distanceInMetres = coordinate1.distance(from: coordinate2)
						
						var V = Float(distanceInMetres)
						if(distanceInMetres <= 1000){
							
							placeTransitionArray.placeDistance = "\(V)"+" metres"
						}else {
							V /= 1000
							placeTransitionArray.placeDistance = "\(V)"+" KM"
						}
						
						
						
					}
				}
		
				
				
			
			}
			
		}
		
		task2.resume()
		
		
	}
	
	
	@IBAction func purchaseCoupon(_ sender: Any) {
		
		
		
		
		
		
		
		if purchaseOrContactValue == 0 {
			getPurchaseCommand()
		}
		
		
		if purchaseOrContactValue == 1{
			
			if let phone = placeTransitionArray.phoneNumber{
				let newString = phone.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
				callNumber(phoneNumber: newString )
			}else{
				print("sorry no contact available")
				let alert = UIAlertController(title: "Not Available", message: "", preferredStyle: UIAlertControllerStyle.alert)
				alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
				self.present(alert, animated: true, completion: nil)

			}
			
			
		}
		
		if purchaseOrContactValue == 2{
			
			// MARK:- set the purchasing of coupon here
			let alert = UIAlertController(title: "Coming Soon", message: "", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			
			
		}
		
		
		
		
	}
	
	
	private func callNumber(phoneNumber:String) {
		if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
			let application:UIApplication = UIApplication.shared
			if (application.canOpenURL(phoneCallURL)) {
				application.open(phoneCallURL, options: [:], completionHandler: nil)
			}
		}
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		getPlaceInfoById()
		
		

	}
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	
	
	if (segue.identifier == "viewplace") {
		let showPlace = segue.destination as! PlacesSecondaryVC
		showPlace.transitionValue = offerToPlaceTransition
		showPlace.transitionedId = homeOfferReceived.offerById
		
		
		showPlace.name = placeTransitionArray.placeName
		showPlace.address = placeTransitionArray.placeAddress
		showPlace.placeDescriptionValue = placeTransitionArray.placeDescription
		showPlace.distance = placeTransitionArray.placeDistance
		showPlace.rating = placeTransitionArray.placeRating
		showPlace.placeTypeValue = placeTransitionArray.placeType
		showPlace.placePhoneNumber = placeTransitionArray.phoneNumber
		showPlace.mapURL = placeTransitionArray.mapURL
		showPlace.placeImageImg = placeTransitionArray.placeImage
		showPlace.placeImgDesc = placeTransitionArray.image1
		showPlace.titleNotification = placeTransitionArray.placeType
		showPlace.photoLink = placeTransitionArray.photoLink
		showPlace.mainUrl = placeTransitionArray.placeFirstImageUrl
		showPlace.secondaryUrl = placeTransitionArray.placeSecondImageUrl
		showPlace.lat = placeTransitionArray.latFinal
		showPlace.long = placeTransitionArray.longFinal
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
