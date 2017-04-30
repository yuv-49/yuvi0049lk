//
//  ViewController.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON



class HomeFirstVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate ,iCarouselDelegate, iCarouselDataSource {

	var indexValue: Int!
	var sliderCount: Int!
	var numberOfEvent: Int!
	var valueForList: Int!
	
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
		
		carouselView.type = .linear
		
		
		if(firstPageNews.count == 0){
		
		
			firstpageNewsApi()
		}
		
		
		
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
		
		return firstPageNews.count
	}
	
	
	
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		sliderCount = 0
		super.viewDidAppear(animated)
		
		Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.runMethod), userInfo: nil, repeats: true)
		
	
	}
	func runMethod() {
		carouselView.scrollToItem(at: sliderCount, animated: true)
		if sliderCount == firstPageNews.count {
			sliderCount = 0
		}
		else {
			sliderCount = sliderCount + 1
		}
	}
	
	
	func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
		

			let tempView = UIView(frame: CGRect(x:0,y:0,width: self.view.frame.width,height: self.view.frame.height/2.5))
			tempView.backgroundColor = UIColor.blue
			
			
		
		let link = URL(string: firstPageNews[index].imageLink)!
		hotNowImage.kf.setImage(with: link)
			
		
			
			tempView.addSubview(hotNowImage)
			
			
			
			
			return tempView


		
		

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
		cell.firstImage.image = UIImage(named:"Events")
		cell.firstLabel.text = firstView[indexPath.row]
		
		return cell
	}

	
	// MARK: UICollectionViewDelegate
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

		return CGSize(width: collectionView.frame.width * 0.33, height: collectionView.frame.height * 0.33)
	}
	
	
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		
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

