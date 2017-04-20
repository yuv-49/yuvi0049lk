//
//  FoodCVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 16/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FoodCVC: UICollectionViewController {
	//var indexValues: Int!
	var indexValueSecond: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
		return restaurantOrder.count
	}
	else if(indexValueSecond == 1){
		return GroceriesOrder.count
	}
	else if(indexValueSecond == 2){
		return MedicineOrder.count
	}
	else {
		return staitionaryOrder.count
	}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodcvcell", for: indexPath) as! FoodCVCell
    
	  if(indexValueSecond == 0){
		  updateValues(restaurantOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 1){
		  updateValues(GroceriesOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 2){
		  updateValues(MedicineOrder, cellForRow: indexPath, TableCell: cell)
	  }
	  else if(indexValueSecond == 3){
		  updateValues(staitionaryOrder, cellForRow: indexPath, TableCell: cell)
	  }
	
	
	return cell
	}
	
	
	func updateValues(_ valueForPlaces:[Places],cellForRow indexPath: IndexPath, TableCell TVcell:FoodCVCell ){
		
		
		
		
		if(valueForPlaces[indexPath.row].placeFirstImageUrl != nil){
			
			
			TVcell.foodPlaceImage.kf.setImage(with: valueForPlaces[indexPath.row].placeFirstImageUrl)
		} else {
			print("Add the default image on places")
		}
		
		
		
		
		TVcell.foodPlaceName.text = valueForPlaces[indexPath.row].placeName
		TVcell.foodPlaceDistance.text = valueForPlaces[indexPath.row].placeDistance
		//TVcell.foodPlaceImage.image = valueForPlaces[indexPath.row].placeImage
		TVcell.foodPlaceRating.text = valueForPlaces[indexPath.row].placeRating
		TVcell.foodPlaceRating.text?.append("★")

		
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
