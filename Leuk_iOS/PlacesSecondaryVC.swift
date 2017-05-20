//
//  PlacesSecondaryVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 11/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class PlacesSecondaryVC: UIViewController {
	
	
	var name: String!
	var address: String!
	var placeDescriptionValue: String!
	var distance: String!
	var rating: String!
	var placeTypeValue: String!
	var placePhoneNumber: String!
	var mapURL: String!
	var titleNotification: String!
	var placeImageImg: UIImage!
	var placeImgDesc: UIImage!
	var photoLink: String!
	var mainUrl: URL!
	var secondaryUrl: URL!
	
	
	var transitionedId: String!
	
	
	var transitionValue: Int!

	
	
	

	
	@IBOutlet weak var placeImage: UIImageView!
	@IBOutlet weak var placeName: UILabel!
	@IBOutlet weak var placeAddress: UILabel!
	@IBOutlet weak var placeDescription: UILabel!
	@IBOutlet weak var placeDistance: UILabel!
	@IBOutlet weak var placeRating: UILabel!
	@IBOutlet weak var placeType: UILabel!
	@IBOutlet weak var placeImageDescription: UIImageView!

	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
	if offerToPlaceTransition == 0{
		insertValues()
	}else if offerToPlaceTransition == 1 {
		
		
		//do here
		
		
		if placeTransitionArray.placeId == nil {
			
			haltForaWhile()
			
		}else{
			insertValues()
		}
		
		
		offerToPlaceTransition = 0
	}
	
    }
	
	func haltForaWhile(){
		
		if placeTransitionArray.placeId == nil{
		
		_ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.haltForaWhile), userInfo: nil, repeats: false);
		}
	}
	
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
	func insertValues(){
		
		
		
		
		
	 self.placeName.text = name
	 self.placeAddress.text = address
	 self.placeDescription.text = placeDescriptionValue
		
	 self.placeDistance.text = distance
	 self.placeDistance.text?.append(" away from your location")
	 self.placeRating.text = rating
	 self.placeType.text = placeTypeValue
	 self.placeImage.image = placeImageImg
	 self.placeImageDescription.image = placeImgDesc
		
		fetchImage()
		
	}

	func fetchImage(){
		self.placeImage.kf.setImage(with: mainUrl)
		self.placeImageDescription.kf.setImage(with: secondaryUrl)

	}
	
	

	
	
	@IBAction func callButtonPressed(_ sender: Any) {
		let newString = placePhoneNumber.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)

		callNumber(phoneNumber: newString)
	}
	
	private func callNumber(phoneNumber:String) {
		if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
			let application:UIApplication = UIApplication.shared
			if (application.canOpenURL(phoneCallURL)) {
				application.open(phoneCallURL, options: [:], completionHandler: nil)
			}
		}
	}

	
	
	@IBAction func messageButtonPressed(_ sender: Any) {
	}
	
	//MARK:- work on location of place
	
	@IBAction func shareButtonPressed(_ sender: Any) {
		shareMessage()
		
	}
	
	func shareMessage(){
		
		//Set the default sharing message.
		let message = "hey! check out \(name!) on Leuk!"
		//Set the link to share.
		if let link = NSURL(string: "https://play.google.com/store/apps/details?id=com.webloominc.leuk&ah=gtJ_axVWQtb6CxEeLC5ypDB3LB8&hl=en-GB")
		{
			let objectsToShare = [message,link] as [Any]
			let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
			activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
			self.present(activityVC, animated: true, completion: nil)
		}
		
	}
	
	
	@IBAction func reviewButtonPressed(_ sender: Any) {
	}
	
	
	
	@IBAction func locationButtonPressed(_ sender: Any) {
		//UIApplication.shared.open(NSURL(string: mapURL)! as URL, options: [:], completionHandler: nil)
		//UIApplication.shared.openURL(URL(string:mapURL)!)
		UIApplication.shared.open(URL(string:mapURL)!, options: [:], completionHandler: nil)
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
