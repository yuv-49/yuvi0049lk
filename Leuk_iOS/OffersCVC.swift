//
//  OffersCVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

private let reuseIdentifier = "offerscvcell"

class OffersCVC: UICollectionViewController {
	
	
	var indexValue: Int!
	var indexValueSecond: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
	if(indexValueSecond == 0){
		return homeOffersHappy.count
	}
	else if(indexValueSecond == 1){
		return homeOfferesApparels.count
	}
	else if(indexValueSecond == 2){
		return homeOffersF_B.count
	}
	else if(indexValueSecond == 3){
		return homeOffersBars.count
	}
	else if(indexValueSecond == 4){
		return homeOffersSpa.count
	}
	else {
		return homeOffersSports.count
	}
	
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)  as! OffersCVCell
    
	if(indexValueSecond == 0){
		updateValues(homeOffersHappy, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 1){
		updateValues(homeOfferesApparels, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 2){
		updateValues(homeOffersF_B, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 3){
		updateValues(homeOffersBars, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 4){
		updateValues(homeOffersSpa, cellForRow: indexPath, TableCell: cell)
	}
	else {
		updateValues(homeOffersSports, cellForRow: indexPath, TableCell: cell)
	}
	
	return cell
	}
	
	
	func updateValues(_ valueForPlaces:[HomeOffers],cellForRow indexPath: IndexPath, TableCell TVcell:OffersCVCell ){
		
		
		
		TVcell.offerPlaceName.text = valueForPlaces[indexPath.row].offerBy
		TVcell.offerDiscount.text = valueForPlaces[indexPath.row].offerDiscount
		TVcell.offerCouponDeal.text = valueForPlaces[indexPath.row].offerDeal
		TVcell.offerPlaceImage.image = valueForPlaces[indexPath.row].offerImageOriginal
	
	}
	
	
	
	
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
