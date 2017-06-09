//
//  HomeSecondVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit



class HomeSecondVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, iCarouselDelegate, iCarouselDataSource{

	@IBOutlet weak var carouselV: iCarousel!
	@IBOutlet weak var homeSecCollectionView: UICollectionView!
	
	var indexValue: Int!
	var indexValueSecond: Int!
	
	var timerDel: Timer!

	var firstView = ["SHOP","OFFERS","EVENTS","PLACES","Ask Leuk","Discover","Contests","Subscriptions","Profile"]
	var orderNowImageForDefault = ["foodandbeverage","groceries","medicines","stationary"]
	var offersImageForDefault = ["happyhours","apparels","foodandbeverage","pubsandbar","spaandsalons","sports"]
	var eventsImageForDefault = ["foodandbeverage","social","startup","sports","meetups","parties"]
	var placesImageForDefault = ["foodandbeverage","entertainment","pubsandbar","cafe","store","medicalstores"]
	
	
	
	
	var secondOrderView = ["Food & Beverages","Groceries","Medicine","Stationary"]
	var secondOffersView = ["Happy Hours","Apparels","Food & Beverages","Bars & Pubs","Spa & Salons","Sports"]
	var secondEventsView = ["Food & Beverages","Social","Startups","Sports","Meetups","Parties"]
	var secondPlacesView = ["Food & Beverages","Entertainment","Pubs","Cafe","Stores","Medical"]

	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
	 setNavTitle()
	
	let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	
	layout.minimumInteritemSpacing = 0
	layout.minimumLineSpacing = 0
	

	homeSecCollectionView!.collectionViewLayout = layout
	
	
	carouselV.type = .linear
	carouselV.isPagingEnabled  = true
	carouselV.bounces = true
	carouselV.bounceDistance = 0.5
	
	Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)

    }

	
	
	func setNavTitle(){
		var i = 0
		for val in firstView {
			
			if(indexValue == i){
				self.title = val
				
			}
			i = i + 1

		}
		
		
		
	}
	
	
	
	

	// MARK: UICollectionViewDataSource
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
		if indexValue == 0{
			return secondOrderView.count
		}
		else if indexValue == 1{
			return secondOffersView.count
		}
		else if indexValue == 2{
			return secondEventsView.count
		}
		else if indexValue == 3{
			return secondPlacesView.count
		}
		return 1
	}
	
	
//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//		if indexValue == 0{
//			// initiate the value once again after  implementing the pagingview
//			
//			return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.height * 0.55)
//		}
//		else {
//			return CGSize(width: collectionView.frame.width * 0.48, height: collectionView.frame.height * 0.28)
//		}
//	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! HomeSecondCVCell
		
		cell.layer.shadowColor = UIColor.gray.cgColor
		cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
		cell.layer.shadowRadius = 1.0
		cell.layer.shadowOpacity = 0.6
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
		
		
		if indexValue == 0{
			cell.secondlabel.text = secondOrderView[indexPath.row]
			cell.secondImage.image = UIImage(named: orderNowImageForDefault[indexPath.row] )
		}
		else if indexValue == 1{
			cell.secondlabel.text = secondOffersView[indexPath.row]
			cell.secondImage.image = UIImage(named: offersImageForDefault[indexPath.row] )
		}
		else if indexValue == 2{
			cell.secondlabel.text = secondEventsView[indexPath.row]
			cell.secondImage.image = UIImage(named: eventsImageForDefault[indexPath.row] )
		}
		else if indexValue == 3{
			cell.secondlabel.text = secondPlacesView[indexPath.row]
			cell.secondImage.image = UIImage(named: placesImageForDefault[indexPath.row] )
		}

		
		return cell
	}
	

	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexValue == 0 {
			return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height * 0.415)

			
		}else{
			return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height * 0.28)
		}
	}
	
	
	
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		if (indexValue == 3)
		{
			
			     indexValueSecond = indexPath.row
			     self.performSegue(withIdentifier: "PlacesFirstTVC", sender: self)
			
			
		}
		else if (indexValue == 2) {
			
			indexValueSecond = indexPath.row
			self.performSegue(withIdentifier: "maineventsegue", sender: self)
		}
		else if (indexValue == 1) {
			indexValueSecond = indexPath.row
			self.performSegue(withIdentifier: "mainoffersegue", sender: self)
		} else if (indexValue == 0) {
			indexValueSecond = indexPath.row
			self.performSegue(withIdentifier: "foodcvc", sender: self)

		}
	}
	
	// MARK:- carousel
	
	func numberOfItems(in carousel: iCarousel) -> Int {
		
		
		if indexValue == 0{
			return pageOneValues.count
		}
		else if indexValue == 1{
			return pageTwoValues.count
		}
		else if indexValue == 2{
			return pageThreeValues.count
		}
		else{
			return pageFourValues.count
		}
		
	}
	
	
	func reloadCarousel(){
		
		carouselV.reloadData()
		
		
		
		
		
	}
	
	
	func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
		
		
		let tempView = UIView(frame: CGRect(x: 5, y: 0, width: self.view.frame.width - 10, height: self.view.frame.height * 0.50))
		tempView.backgroundColor = UIColor.white
//		print("IMP \(self.view.frame.height * 0.10)")
		
		
		
		
		
		let imageView = UIImageView()
		
		var link : URL!
		
		if indexValue == 0{
			
			link = pageOneValues[index].placeFirstImageUrl
			
		}
		else if indexValue == 1{
			link = URL(string: pageTwoValues[index].offerImage)!

			
		}
		else if indexValue == 2{
			link = URL(string: pageThreeValues[index].eventImageLink)!
			
		}
		else{
			link = pageFourValues[index].placeFirstImageUrl

		}

		
		
		
		
		imageView.kf.setImage(with: link)
		imageView.frame = CGRect(x: 1, y: 50 , width: self.view.frame.width - 12, height: self.view.frame.height * 0.317)
		tempView.addSubview(imageView)
		
		
		let label0 = UILabel()
		label0.frame = CGRect(x: 4, y: self.view.frame.height * 0.395, width: self.view.frame.width/3, height: self.view.frame.height * 0.05)
		label0.textAlignment = NSTextAlignment.left
		label0.textColor = UIColor.lightGray
		label0.adjustsFontSizeToFitWidth = true
		label0.font = UIFont(name: "Avenir Next", size: label0.font.pointSize)
		
		var stringUpper: String!
		
		if indexValue == 0{
			
			stringUpper = pageOneValues[index].placeType.uppercased()
			
		}
		else if indexValue == 1{
			stringUpper = pageTwoValues[index].offerCategory.uppercased()
			
			
		}
		else if indexValue == 2{
			stringUpper = pageThreeValues[index].eventCategory.uppercased()
			
		}
		else{
			stringUpper = pageFourValues[index].placeType.uppercased()
			
		}
		
		
		
		
		
		
		label0.text = stringUpper
		tempView.addSubview(label0)
		
		let label1 = UILabel()
		label1.frame = CGRect(x: 6, y: self.view.frame.height * 0.427, width: self.view.frame.width * 0.95, height: self.view.frame.height * 0.04)
		label1.textAlignment = NSTextAlignment.left
		label1.adjustsFontSizeToFitWidth = true
		
		var stringUpper1: String!
		
		if indexValue == 0{
			
			stringUpper1 = pageOneValues[index].placeName
			
		}
		else if indexValue == 1{
			stringUpper1 = pageTwoValues[index].offerBy
			
			
		}
		else if indexValue == 2{
			stringUpper1 = pageThreeValues[index].eventHostedBy
			
		}
		else{
			stringUpper1 = pageFourValues[index].placeName
			
		}
		
		
		
		
		
		//stringUpper = firstPageNews[index].newsSource.uppercased()
		//firstPageNews[index].newsSource..uppercased
		label1.text = stringUpper1

		
		
		
		
		
		//label1.text = firstPageNews[index].newsTitle!
		label1.font = UIFont(name: "Avenir Next", size: 12)
		tempView.addSubview(label1)
		
		
		
		
		
		
		if indexValue == 1 {
			
			let dot = UIImageView(frame: CGRect(x: 4, y: self.view.frame.height * 0.463, width: 25, height: 25))
			dot.image = UIImage(named: "location-1")
			tempView.addSubview(dot)
			
			
			
			
			
			
		}else{
			
			let dot = UIImageView(frame: CGRect(x: 4, y: self.view.frame.height * 0.463, width: 25, height: 25))
			dot.image = UIImage(named: "bell")
			tempView.addSubview(dot)

			
			let label2 = UILabel()
			label2.frame = CGRect(x: 26, y: self.view.frame.height * 0.463, width: self.view.frame.width , height: self.view.frame.height * 0.03)
			label2.textAlignment = NSTextAlignment.left
			label2.adjustsFontSizeToFitWidth = true
			label2.font = UIFont(name: label2.font.fontName, size: 13)
			var views: String!
			
			if indexValue == 0{
				
				views = pageOneValues[index].views
				
			}
			
			else if indexValue == 2{
				views = pageThreeValues[index].views
				
			}
			else{
				views = pageFourValues[index].views
				
			}
			
			
			
			label2.text = "\(views!) people have viewed this"
			tempView.addSubview(label2)
			

			
			
		}
		
		
		
		
		
		
		
		
		
		

		
		
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
	
	
	
	

	
	
//	func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
//		
//		linkToCall = firstPageNews[index].pageLink
//		callLinkFunc()
//		
//	}
//	
//	
//	
//	
//	func callLinkFunc(){
//		
//		if let link = linkToCall {
//			
//			UIApplication.shared.openURL(NSURL(string: link)! as URL)
//			
//		}
//		
//		
//		
//	}
	
	
	
	
	
	
	
	func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
		if option == iCarouselOption.spacing{
			return value * 1.1
		}
		return value
	}
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
		
		
		timerDel = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.reloadCarousel), userInfo: nil, repeats: true)
	
	}
	
	
	
	func autoScroll(){
		
		carouselV.scrollToItem(at: carouselV.currentItemIndex + 1, animated: true)
		
		var count: Int!
		
		if indexValue == 0{
			
			count = pageOneValues.count
			
		}
		else if indexValue == 1{
			count = pageTwoValues.count
			
			
		}
		else if indexValue == 2{
			count = pageThreeValues.count
			
		}
		else{
			count = pageFourValues.count
			
		}
		
		
		if carouselV.currentItemIndex ==  count - 1{
			
			Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(self.runMethod1), userInfo: nil, repeats: false)
		}else{
			// do anything,doesn't matter...
			
		}
		
		
	}
	
	
	
	
	
	func runMethod1(){
		carouselV.scrollToItem(at: 0, animated: true)
	}
	
	
	
	
	
	
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PlacesFirstTVC") {
		

		timerDel.invalidate()
		let placesFirstTVC = segue.destination as! PlacesFirstTVC
		placesFirstTVC.indexValueSecond = indexValueSecond
		//placesFirstTVC.indexValue = indexValue
		
	}
	else if(segue.identifier == "maineventsegue"){
		
		timerDel.invalidate()
		
		let eventsTVC = segue.destination as! EventsTVC
		eventsTVC.indexValueSecond = indexValueSecond
	}
	else if(segue.identifier == "mainoffersegue"){
		
		timerDel.invalidate()
		
			let offersCVC = segue.destination as! OffersCVC
			offersCVC.indexValue = indexValue
			offersCVC.indexValueSecond = indexValueSecond
	}
	else if(segue.identifier == "foodcvc"){
		
		timerDel.invalidate()
		
		let foodCVC = segue.destination as! FoodCVC
		//FoodCVC.indexValues = indexValue
		foodCVC.indexValueSecond = indexValueSecond
		
		
		 
		
		
		
	}
    }
    

}
