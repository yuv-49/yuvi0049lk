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
	var idValuetoPass: String!
	var offerClassToPass = HomeOffers()

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
		
		let url = URL(string: valueForPlaces[indexPath.row].offerImage)
		TVcell.offerPlaceImage.kf.setImage(with: url)
		
		
		
		//TVcell.offerPlaceImage.image = valueForPlaces[indexPath.row].offerImageOriginal
	
	}
	
	
	
	
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		//	let indexPathValues = collectionView.indexPathsForSelectedItems
		
		
		
		if(indexValueSecond == 0){
			
			
			
			addValueToSegue(homeOffersHappy[indexPath.row])
			

		}
		else if(indexValueSecond == 1){
			
			addValueToSegue(homeOfferesApparels[indexPath.row])

			
		}
		else if(indexValueSecond == 2){
			
			addValueToSegue(homeOffersF_B[indexPath.row])

			
		}
		else if(indexValueSecond == 3){
			
			addValueToSegue(homeOffersBars[indexPath.row])

		}
		else if(indexValueSecond == 4){
			
			addValueToSegue(homeOffersSpa[indexPath.row])

		}
		else if(indexValueSecond == 5){
			
			addValueToSegue(homeOffersSports[indexPath.row])

		}
		self.performSegue(withIdentifier: "OffersIndividualVC", sender: self)



		
	}
	
	
	func addValueToSegue(_ homeOffer: HomeOffers){
		
		
		offerClassToPass.offerBy = homeOffer.offerBy
		offerClassToPass.offerById = homeOffer.offerById
		offerClassToPass.offerCategory = homeOffer.offerCategory
		offerClassToPass.offerDeal = homeOffer.offerDeal
		offerClassToPass.offerImage = homeOffer.offerImage
		offerClassToPass.offerDiscount = homeOffer.offerDiscount
		offerClassToPass.offerTitle = homeOffer.offerTitle
		offerClassToPass.offerImageOriginal = homeOffer.offerImageOriginal
		offerClassToPass.offerDesc = homeOffer.offerDesc
		offerClassToPass.offerExpiry = homeOffer.offerExpiry
		offerClassToPass.offerTiming = homeOffer.offerTiming
		
		
	}
	
	
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if (segue.identifier == "OffersIndividualVC") {
			let offersSecondaryVC = segue.destination as! OffersIndividualVC
			
			
			
			
			
			
			offersSecondaryVC.homeOfferReceived.offerBy = offerClassToPass.offerBy
			offersSecondaryVC.homeOfferReceived.offerById = offerClassToPass.offerById
			offersSecondaryVC.homeOfferReceived.offerCategory = offerClassToPass.offerCategory
			offersSecondaryVC.homeOfferReceived.offerDeal = offerClassToPass.offerDeal
			offersSecondaryVC.homeOfferReceived.offerImage = offerClassToPass.offerImage
			offersSecondaryVC.homeOfferReceived.offerDiscount = offerClassToPass.offerDiscount
			offersSecondaryVC.homeOfferReceived.offerTitle = offerClassToPass.offerTitle
			offersSecondaryVC.homeOfferReceived.offerImageOriginal = offerClassToPass.offerImageOriginal
			offersSecondaryVC.homeOfferReceived.offerDesc = offerClassToPass.offerDesc
			offersSecondaryVC.homeOfferReceived.offerExpiry = offerClassToPass.offerExpiry
			offersSecondaryVC.homeOfferReceived.offerTiming = offerClassToPass.offerTiming
			
			
		}
		
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	


}
