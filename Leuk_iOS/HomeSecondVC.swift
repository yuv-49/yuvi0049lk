//
//  HomeSecondVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit



class HomeSecondVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

	@IBOutlet weak var homeSecCollectionView: UICollectionView!
	
	var indexValue: Int!
	var indexValueSecond: Int!

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
	
        // Do any additional setup after loading the view.
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
	
	
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PlacesFirstTVC") {
		

		let placesFirstTVC = segue.destination as! PlacesFirstTVC
		placesFirstTVC.indexValueSecond = indexValueSecond
		//placesFirstTVC.indexValue = indexValue
		
	}
	else if(segue.identifier == "maineventsegue"){
		
		let eventsTVC = segue.destination as! EventsTVC
		eventsTVC.indexValueSecond = indexValueSecond
	}
	else if(segue.identifier == "mainoffersegue"){
		
			let offersCVC = segue.destination as! OffersCVC
			offersCVC.indexValue = indexValue
			offersCVC.indexValueSecond = indexValueSecond
	}
	else if(segue.identifier == "foodcvc"){
		
		let foodCVC = segue.destination as! FoodCVC
		//FoodCVC.indexValues = indexValue
		foodCVC.indexValueSecond = indexValueSecond
		
		
		 
		
		
		
	}
    }
    

}
