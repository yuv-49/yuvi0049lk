//
//  ViewController.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit



class HomeFirstVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

	var indexValue: Int!

	@IBOutlet weak var open: UIBarButtonItem!
	
	
	
	
	@IBOutlet weak var firstCollectionView: UICollectionView!
		
	
	var firstView = ["Order Now","Offers","Events","Places","Ask Leuk","Discover","Contests","Subscriptions","Profile"]
		
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "LEUK"

		open.target = self.revealViewController()
		open.action = #selector(SWRevealViewController.revealToggle(_:))
		
		revealControllerToggle()
		
		
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

