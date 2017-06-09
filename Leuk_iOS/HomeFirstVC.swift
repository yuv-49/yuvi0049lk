//
//  ViewController.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON



class HomeFirstVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate ,iCarouselDelegate, iCarouselDataSource, UICollectionViewDelegateFlowLayout ,UIPickerViewDelegate, UIPickerViewDataSource{
	
	
	
	
	
	@IBOutlet weak var currentLocation: UILabel!
//	@IBOutlet weak var doneBtnTapped: UILabel!
	
	
	@IBOutlet weak var locationPicker: UIPickerView!
	
	
	
	var pickerDataSource = [String]()//= ["Manipal", "Bangalore", "Gurgaon", "Ranchi"]
	var locationVal: String!

	

	var indexValue: Int!
	var sliderCount: Int!
	var numberOfEvent: Int!
	var valueForList: Int!
	
	var linkToCall : String!
	
	var timerDel : Timer!
	
	
	@IBOutlet weak var locationPopup: UIView!
	
	
	@IBOutlet weak var open: UIBarButtonItem!
	
	@IBOutlet weak var carouselView: iCarousel!
	
	
	
	@IBOutlet weak var firstCollectionView: UICollectionView!
		
	
	var firstView = ["Order Now","Offers","Events","Places","Ask Leuk","Discover","Contests","Subscriptions","Profile"]
	var firstImage = ["nshop-2","noffers-2","nevents-2","nplaces-2","ask-3","compass-2","medal","tatti","done-2"]
	
	var navBar: UINavigationBar = UINavigationBar()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	//	self.title = "LEUK"
		
		locationPopup.isHidden = true
		
		
		
		currentLocation.text = area
		
		self.setNavBarToTheView()
		locationPicker.delegate = self
		locationPicker.dataSource = self

		open.target = self.revealViewController()
		open.action = #selector(SWRevealViewController.revealToggle(_:))
		
		revealControllerToggle()
		//count = 0
		
		carouselView.type = .linear
		carouselView.isPagingEnabled  = true
		carouselView.bounces = true
		carouselView.bounceDistance = 0.5
		
		
		
//		let gestureForLocation = UITapGestureRecognizer(target: self, action:  #selector (self.changeLoc (_:)))
//		self.doneBtnTapped.addGestureRecognizer(gestureForLocation)

		
		//carouselView.autoscroll = 4.0
		
//		let rightButtonItem = UIBarButtonItem.init(
//			title: "Title",
//			style: .done,
//			target: self,
//			action: "rightButtonAction:",
//			
//		)
		
		

		
		
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		
		
		firstCollectionView!.collectionViewLayout = layout
		
		
		Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
		
		
	}
	
	
	
	func changeLoc(_ sender:UITapGestureRecognizer){
		
		self.locationPopup.isHidden = true
	//	print("here we are")
		
		changeLocApiCall()
		
		
		//	self.performSegue(withIdentifier: "restartAgain", sender: nil)
		
		
	}
	
	func changeLocApiCall(){
		
		if locationVal == nil {
			
			locationVal = pickerDataSource[0]

		}
		
		
		var value: Int!
		var locationUpdate = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=updateUserLocation")!)
		locationUpdate.httpMethod = "POST"
		let postString1="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&location=\(locationVal!)"
		print("happy sinn \(postString1)")
		
		
		locationUpdate.httpBody = postString1.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: locationUpdate) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				//print("RFcss")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
				
				DispatchQueue.main.async {
					
					value = 1
					
					
				}
				
				
				print("successful")
				
				
				
				
			}
			
		}
		
		task2.resume()
		

		self.performSegue(withIdentifier: "restartAgain", sender: nil)
		
		
		
		
	}
	
	func setNavBarToTheView() {
		self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
		self.navBar.backgroundColor = (UIColor.white)
		self.navBar.titleTextAttributes =  [NSForegroundColorAttributeName: UIColor.leukRed()]

		//self.navBar.barTintColor = UIColor.leukRed()
		//self.navBar.isTranslucent = false
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
	
	
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	
	
	//MARK:- Picker delegates
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		

		if pickerDataSource.count == 0 {
			Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(pickerCall), userInfo: nil, repeats: false)
		}
		return pickerDataSource.count
	}
 
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerDataSource[row]
	}
	
	
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{

		if(row == 0)
		{
			locationVal = pickerDataSource[row]
			
		}
		else if(row == 1)
		{
			print(pickerDataSource[row])
			locationVal =  pickerDataSource[row]
			
		}
		else if(row == 2)
		{
			print(pickerDataSource[row])
			locationVal = pickerDataSource[row]
		}
	   }
	

	func pickerCall(){
		
		if pickerDataSource.count != 0 {
			
			locationPicker.reloadAllComponents()
		}else{
			Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.pickerCall), userInfo: nil, repeats: false)
		}
		
		
	}
	
	
	
	
	//MARK:- iCarouselView
	
	
	
	func numberOfItems(in carousel: iCarousel) -> Int {


		

		
		
		return firstPageNews.count
	}
	
	
	func reloadCarousel(){
		
		
		
		carouselView.reloadData()

		
		

		
	}
	
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
		
		
		timerDel = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.reloadCarousel), userInfo: nil, repeats: true)
		//Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.checkForData), userInfo: nil, repeats: false)
	}
	
	
	
	func autoScroll(){
		
		carouselView.scrollToItem(at: carouselView.currentItemIndex + 1, animated: true)

		
		if carouselView.currentItemIndex ==  firstPageNews.count - 1{
		
			Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.runMethod1), userInfo: nil, repeats: false)
		}else{
			
			
		}
		

	}
	
	
	

	
	func runMethod1(){
		carouselView.scrollToItem(at: 0, animated: true)
	}
	
	
//	func checkForData(){
//		
//		
//		if firstPageNews.count == 0 {
//		
//		
//		let timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.checkForData), userInfo: nil, repeats: false)
//		}
//	}
	
	
	func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
		
		
		let tempView = UIView(frame: CGRect(x: 5, y: 0, width: self.view.frame.width - 10, height: self.view.frame.height * 0.50))
		tempView.backgroundColor = UIColor.white
		print("IMP \(self.view.frame.height * 0.10)")
		

		let imageView = UIImageView()
		let link = URL(string: firstPageNews[index].imageLink)!
		imageView.kf.setImage(with: link)
		imageView.frame = CGRect(x: 1, y: 50 , width: self.view.frame.width - 12, height: self.view.frame.height * 0.317)
		tempView.addSubview(imageView)
		
		
		let label0 = UILabel()
		label0.frame = CGRect(x: 4, y: self.view.frame.height * 0.395, width: self.view.frame.width/3, height: self.view.frame.height * 0.05)
		label0.textAlignment = NSTextAlignment.left
		label0.textColor = UIColor.lightGray
		label0.adjustsFontSizeToFitWidth = true
		label0.font = UIFont(name: "Avenir Next", size: label0.font.pointSize)
		let stringUpper = firstPageNews[index].newsSource.uppercased()
		//firstPageNews[index].newsSource..uppercased
		label0.text = stringUpper
		tempView.addSubview(label0)
		
		let label1 = UILabel()
		label1.frame = CGRect(x: 4, y: self.view.frame.height * 0.427, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.04)
		label1.textAlignment = NSTextAlignment.left
		label1.adjustsFontSizeToFitWidth = true
		label1.text = firstPageNews[index].newsTitle!
		label1.font = UIFont(name: "Avenir Next", size: 12)
		tempView.addSubview(label1)
		
		
		let dot = UIImageView(frame: CGRect(x: 4, y: self.view.frame.height * 0.463, width: 25, height: 25))
		dot.image = UIImage(named: "bell")
		tempView.addSubview(dot)
		
		let label2 = UILabel()
		label2.frame = CGRect(x: 26, y: self.view.frame.height * 0.464, width: self.view.frame.width , height: self.view.frame.height * 0.03)
		label2.textAlignment = NSTextAlignment.left
		label2.adjustsFontSizeToFitWidth = true
		label2.font = UIFont(name: label2.font.fontName, size: 13)
		label2.text = "\(firstPageNews[index].hits!) people have viewed this"
		tempView.addSubview(label2)
		
		
		
//		let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.getNewPageOpened (_:)))
//		tempView.addGestureRecognizer(gesture)
		
		
		
		
		tempView.layer.shadowColor = UIColor.lightGray.cgColor
		tempView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
		tempView.layer.shadowRadius = 2.0
		tempView.layer.shadowOpacity = 0.6
		tempView.layer.masksToBounds = false
		//tempView.layer.shadowPath = UIBezierPath(roundedRect: tempView.bounds, cornerRadius: tempView.contentView.layer.cornerRadius).cgPathlayer.borderColor = UIColor.lightGray.cgColor
		
		//tempView.layer.shadowPath = UIBezierPath(roundedRect: tempView.bounds, cornerRadius: tempView.layer.cornerRadius).cgPa
		
		return tempView
		
		
		
		
		
		


		
		

	}
	
	func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
		
		linkToCall = firstPageNews[index].pageLink
		callLinkFunc()
		
	}
	
      func getNewPageOpened(_ sender:UITapGestureRecognizer){
	// do other task
	
	
//	if let link = linkToCall {
//		
//	//	UIApplication.shared.openURL(NSURL(string: link)! as URL)
//
//	}
		print("Hello world")
	}
	
	
	func callLinkFunc(){

		if let link = linkToCall {
			
			UIApplication.shared.openURL(NSURL(string: link)! as URL)
			
		}
		
		
		
	}
	
	
	
	
	
	
	
	func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
		if option == iCarouselOption.spacing{
			return value * 1.1
		}
		return value
	}
	
	
	
	
	
	
	
	
	// MARK: UICollectionViewDataSource
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
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

	
	// MARK: UICollectionViewDelegate
	
//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
//		return CGSize(width: collectionView.frame.width * 0.30, height: collectionView.frame.height * 0.28)
//	}
//	
	
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		
//		let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!  // collectionView.cellForRowAtIndexPath(indexPath)!
//		selectedCell.contentView.backgroundColor = UIColor.red
		
		
		if (indexPath.row >= 0 && indexPath.row <= 3)
		{
			
			indexValue = indexPath.row
			self.performSegue(withIdentifier: "FirstFourCell", sender: self)

		
		} else if(indexPath.row == 8){
			//indexValue = indexPath.row
			self.performSegue(withIdentifier: "profilevc", sender: self)
			
		}
			
		else if(indexPath.row == 5) {
			
			UIAlertView.init(title: "Coming Soon", message: "Hold on For a While", delegate: self, cancelButtonTitle: "OK").show()
			
			
			// MARK:- todo
			//self.performSegue(withIdentifier: "discoverfromhome", sender: self)
		}
		
		
			
		else {
			indexValue = indexPath.row
			
			UIAlertView.init(title: "Coming Soon", message: "Hold on For a While", delegate: self, cancelButtonTitle: "OK").show()
			
			// MARK:- todo
			//self.performSegue(withIdentifier: "RestCell", sender: self)

		}
		
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: self.view.frame.width / 3, height: self.view.frame.height * 0.165)
	}
	
	
	// MARK:- location change tapped
	
	
	@IBAction func changeLocationPopup(_ sender: Any) {
		
		getLocationValues()
		
		
		locationPopup.isHidden = false
		
	}
	
	func getLocationValues(){
		
		var profileRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=getLocations")!)
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
				//print("RFcss")
				//let responseString = String(data: data!, encoding: .utf8)
				//print("responseString = \(responseString!)")
				
				
				
				
				
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
	
//	@IBOutlet weak var doneBtnTappedHere: UIButton!
	
	@IBAction func doneBtnTappedHere(_ sender: Any) {
		
		self.locationPopup.isHidden = true
		print("here we are")
		
		changeLocApiCall()

	}
	
	
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "FirstFourCell") {
			
			timerDel.invalidate()
			let homeSecondVC = segue.destination as! HomeSecondVC
			homeSecondVC.indexValue = indexValue
			
			
			
		}
			
		// MARK: todo
//		else if (segue.identifier == "RestCell") {
//			
//			timerDel.invalidate()
//			
//			let homeThirdVC = segue.destination as! HomeThirdVC
//			homeThirdVC.indexValue = indexValue
//			
//			
//		}
		
		
		
		
		
		
		
		
		
		
//		else if (segue.identifier == "profilevc"){
//			let profilevc = segue.destination as! ProfileVC
//			
//		}
//
		
	}
	
	
	
	

}

