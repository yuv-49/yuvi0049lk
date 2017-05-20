//
//  ViewController.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON



class HomeFirstVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate ,iCarouselDelegate, iCarouselDataSource, UICollectionViewDelegateFlowLayout {

	var indexValue: Int!
	var sliderCount: Int!
	var numberOfEvent: Int!
	var valueForList: Int!
	
	var linkToCall : String!
	
	
	
	
	
	
	@IBOutlet weak var open: UIBarButtonItem!
	
	@IBOutlet weak var carouselView: iCarousel!
	@IBOutlet weak var hotNowImage: UIImageView!
	
	
	
	@IBOutlet weak var firstCollectionView: UICollectionView!
		
	
	var firstView = ["Order Now","Offers","Events","Places","Ask Leuk","Discover","Contests","Subscriptions","Profile"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "LEUK"

		open.target = self.revealViewController()
		open.action = #selector(SWRevealViewController.revealToggle(_:))
		
		revealControllerToggle()
		//count = 0
		
		carouselView.type = .linear
		
		
		// collectionView
		
		let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		
		
		firstCollectionView!.collectionViewLayout = layout

		
		
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

	
	func firstpageNewsApi(){
		
		
		
		//MARK:- FIRST PAGE NEWS
		
		var newsRequest = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=getPopularNews")!)
		newsRequest.httpMethod = "POST"
		let postStringForNews="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
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
	
	
	
	
	
	
	
	
	//MARK:- iCarouselView
	
	
	
	func numberOfItems(in carousel: iCarousel) -> Int {

		if firstPageNews.count != countOfPagesForFirstPage {
			Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.reloadCarousel), userInfo: nil, repeats: false)
		}
		
		return firstPageNews.count
	}
	
	func reloadCarousel(){
		
	
		
		
		if firstPageNews.count != countOfPagesForFirstPage {
			Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.reloadCarousel), userInfo: nil, repeats: false)
		}
		
		carouselView.reloadData()
	}
	
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		carouselView.scroll(toOffset: 0, duration: 0.01)
		
		
		
		
		Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.runMethod), userInfo: nil, repeats: true)
		Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.checkForData), userInfo: nil, repeats: false)
	}
	func runMethod() {

		carouselView.scrollToItem(at: carouselView.currentItemIndex + 1, animated: true)
		if carouselView.currentItemIndex == firstPageNews.count - 1{
			Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.runMethod1), userInfo: nil, repeats: false)
		}
	}
	
	
	
	
	func runMethod1(){
		carouselView.scrollToItem(at: 0, animated: true)
	}
	
	
	func checkForData(){
		
		
		if firstPageNews.count == 0 {
		
		
		Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.checkForData), userInfo: nil, repeats: true)
		}
	}
	
	
	func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
		
		
		let tempView = UIView(frame: CGRect(x: 5, y: 0, width: self.view.frame.width - 10, height: self.view.frame.height * 0.50))
		tempView.backgroundColor = UIColor.clear
		

		let imageView = UIImageView()
		let link = URL(string: firstPageNews[index].imageLink)!
		imageView.kf.setImage(with: link)
		imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 10, height: self.view.frame.height * 0.39)
		tempView.addSubview(imageView)
		
		
		let label0 = UILabel()
		label0.frame = CGRect(x: 10, y: self.view.frame.height * 0.38, width: self.view.frame.width/3, height: self.view.frame.height * 0.06)
		label0.textAlignment = NSTextAlignment.left
		label0.textColor = UIColor.lightGray
		label0.adjustsFontSizeToFitWidth = true
		label0.font = UIFont(name: "Avenir Next", size: label0.font.pointSize)
		let stringUpper = firstPageNews[index].newsSource.uppercased()
		//firstPageNews[index].newsSource..uppercased
		label0.text = stringUpper
		tempView.addSubview(label0)
		
		let label1 = UILabel()
		label1.frame = CGRect(x: 10, y: self.view.frame.height * 0.40, width: self.view.frame.width * 0.90, height: self.view.frame.height * 0.10)
		label1.textAlignment = NSTextAlignment.left
		label1.adjustsFontSizeToFitWidth = true
		label1.text = firstPageNews[index].newsTitle!
		label1.font = UIFont(name: "Avenir Next", size: label1.font.pointSize)
		tempView.addSubview(label1)
		
		
		
		let label2 = UILabel()
		label2.frame = CGRect(x: 10, y: self.view.frame.height * 0.46, width: self.view.frame.width * 0.60, height: self.view.frame.height * 0.06)
		label2.textAlignment = NSTextAlignment.left
		label2.adjustsFontSizeToFitWidth = true
		label2.font = UIFont(name: "Avenir Next", size: label2.font.pointSize)
		label2.text = "\(firstPageNews[index].hits!) people have viewed this"
		tempView.addSubview(label2)
		
		
		
//		let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.getNewPageOpened (_:)))
//		tempView.addGestureRecognizer(gesture)
		
		
		
		
		tempView.layer.shadowColor = UIColor.lightGray.cgColor
		tempView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
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
		cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
		cell.layer.shadowRadius = 2.0
		cell.layer.shadowOpacity = 0.6
		cell.layer.masksToBounds = false
		cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
		
		
		
		
		cell.firstImage.image = UIImage(named:"Events")
		cell.firstLabel.text = firstView[indexPath.row]
		
		return cell
	}

	
	// MARK: UICollectionViewDelegate
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

		return CGSize(width: collectionView.frame.width * 0.30, height: collectionView.frame.height * 0.30)
	}
	
	
	
	
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
			self.performSegue(withIdentifier: "discoverfromhome", sender: self)
		}
		
		
			
		else {
			indexValue = indexPath.row
			self.performSegue(withIdentifier: "RestCell", sender: self)

		}
		
		
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: self.view.frame.width / 3, height: self.view.frame.height * 0.18)
	}
	
	
	
	
	
	
	
	
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "FirstFourCell") {
			let homeSecondVC = segue.destination as! HomeSecondVC
			homeSecondVC.indexValue = indexValue
			
			
			
		}
		else if (segue.identifier == "RestCell") {
			
			let homeThirdVC = segue.destination as! HomeThirdVC
			homeThirdVC.indexValue = indexValue
			
			
		}
//		else if (segue.identifier == "profilevc"){
//			let profilevc = segue.destination as! ProfileVC
//			
//		}
//
		
	}
	
	
	
	

}

