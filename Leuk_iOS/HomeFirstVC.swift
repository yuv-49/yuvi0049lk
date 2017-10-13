//
//  ViewController.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation



class HomeFirstVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate ,iCarouselDelegate, iCarouselDataSource, UICollectionViewDelegateFlowLayout {
	
	
	
	
	
	
	
	
	let locationManager = CLLocationManager()

	
	
	var pickerDataSource = [String]()//= ["Manipal", "Bangalore", "Gurgaon", "Ranchi"]
	var locationVal: String!

	

	var indexValue: Int!
	var sliderCount: Int!
	var numberOfEvent: Int!
	var valueForList: Int!
	
	//var linkToCall : String!
	
	var timerDel : Timer!
	
	

	
	
	@IBOutlet weak var open: UIBarButtonItem!
	
	@IBOutlet weak var carouselView: iCarousel!
	
	
	
	@IBOutlet weak var firstCollectionView: UICollectionView!
		
	
	var firstView = ["Order Now","Offers","Events","Places","Ask Leuk","Discover","Contests","Subscriptions","Profile"]
	var firstImage = ["nshop-2","noffers-2","nevents-2","nplaces-2","ask-3","compass-2","medal","tatti","done-2"]
	
	var navBar: UINavigationBar = UINavigationBar()
	
	var timerOne: Timer!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		
		self.setNavBarToTheView()


		open.target = self.revealViewController()
		open.action = #selector(SWRevealViewController.revealToggle(_:))
		
		revealControllerToggle()
		
		
		carouselView.type = .linear
		carouselView.isPagingEnabled  = true
		carouselView.bounces = true
		carouselView.bounceDistance = 0.5
		
		isAuthorizedtoGetUserLocation()

		

		

		
		
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		
		
		firstCollectionView!.collectionViewLayout = layout
		
		
		timerOne = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
		
		
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
	
	func setNavBarToTheView() {
		self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
		self.navBar.backgroundColor = (UIColor.white)
		self.navBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.leukRed()]

	
		self.navBar.isOpaque = true
		self.view.addSubview(navBar)
	}
	
	
	func revealControllerToggle(){
		
		if revealViewController() != nil {
			open.target = revealViewController()
			open.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		}
		
	}
	
	
	//MARK:- iCarouselView
	
	
	
	func numberOfItems(in carousel: iCarousel) -> Int {
	
		return homeBanners.count
	}
	
	
	func reloadCarousel(){
		carouselView.reloadData()

	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
		
		
		timerDel = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.reloadCarousel), userInfo: nil, repeats: true)
		//Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.checkForData), userInfo: nil, repeats: false)
	}
	
	
	override func viewWillDisappear(_ animated: Bool) {
		timerDel.invalidate()
		timerOne.invalidate()
	}
	
	
	
	func autoScroll(){
		
		carouselView.scrollToItem(at: carouselView.currentItemIndex + 1, animated: true)

		
		if carouselView.currentItemIndex ==  homeBanners.count - 1{
		
			Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.runMethod1), userInfo: nil, repeats: false)
		}else{
			
			
		}
	}
	
	func runMethod1(){
		carouselView.scrollToItem(at: 0, animated: true)
	}
	

	
	
	func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
		
		
		let tempView = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width  , height: self.view.frame.height * 0.33))
		tempView.backgroundColor = UIColor.white
		print("IMP \(self.view.frame.height * 0.10)")
		

		let imageView = UIImageView()
		let link = URL(string: homeBanners[index].image)!
		imageView.kf.setImage(with: link)
		imageView.frame = CGRect(x: 5, y: 50, width: self.view.frame.width - 10, height: self.view.frame.height * 0.33)
		//imageView.contentMode = .scaleAspect
		tempView.addSubview(imageView)
		
		
		
		
		
		
		tempView.layer.shadowColor = UIColor.lightGray.cgColor
		tempView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
		tempView.layer.shadowRadius = 2.0
		tempView.layer.shadowOpacity = 0.6
		tempView.layer.masksToBounds = false
		
		
		return tempView
		
	}
	
	func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
		
		//linkToCall = homeBanners[index].pageLink
		callLinkFunc()
		
	}
	
      func getNewPageOpened(_ sender:UITapGestureRecognizer){

		print("Hello world")
	}
	
	
	func callLinkFunc(){

//		if let link = linkToCall {
//			
//			if #available(iOS 10.0, *) {
//				  UIApplication.shared.open(NSURL(string: link)! as URL, options: [:], completionHandler: nil)
//			} else {
//				  UIApplication.shared.openURL(NSURL(string: link)! as URL)
//			}
//		}
	}
	
	func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
		if option == iCarouselOption.spacing{
			return value * 1.1
		}
		return value
	}
	
	// MARK: UICollectionViewDataSource
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		
		return 1
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		return firstView.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as! HomeFirstCVCell
		
		
		
		cell.layer.shadowColor = UIColor.gray.cgColor
		cell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
		cell.layer.shadowRadius = 2.0
		cell.layer.shadowOpacity = 0.6
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
		
		
		
		
		cell.firstImage.image = UIImage(named:firstImage[indexPath.row])
		cell.firstLabel.text = firstView[indexPath.row]
		
		return cell
	}

	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if (indexPath.row >= 0 && indexPath.row <= 3)
		{
			
			indexValue = indexPath.row
			self.performSegue(withIdentifier: "FirstFourCell", sender: self)

		
		} else if(indexPath.row == 8){
			
			self.performSegue(withIdentifier: "profilevc", sender: self)
			
		}
			
		else if(indexPath.row == 5) {
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Hold on For a While", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
		
		}
		
		
			
		else {
			indexValue = indexPath.row
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Hold on For a While", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				//print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			

		}
		
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: self.view.frame.width / 3, height: self.view.frame.height * 0.165)
	}
	
	

	
	func getLocationValues(){
		
		var profileRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getLocations")!)
		profileRequest.httpMethod = "POST"
		let postString1="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postString1)")
		
		
		profileRequest.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: profileRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				
			}
				
			else {
				
				
				
				
				
				
				var json = JSON(data: data!)
				let numberOfEventsV =  json["response"]["data"].count
				
				if numberOfEventsV > 0 {
					
					for values in 0...numberOfEventsV - 1 {
						let value = json["response"]["data"][values].string!
						self.pickerDataSource.append(value)
						print(value)
						
					}
				}
				
				
				
				

			}
			
		}
		
		task2.resume()

		
		
		
	}

	
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "FirstFourCell") {
			
			timerDel.invalidate()
			let homeSecondVC = segue.destination as! HomeSecondVC
			homeSecondVC.indexValue = indexValue
			
			
			
		}

		
	}
}

