//
//  PlacesFirstTVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 11/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation
import Kingfisher

class PlacesFirstTVC: UITableViewController {

	//var indexValue: Int!
	var place1 = Places()
	var indexValueSecond: Int!
	var indexValuePlacesDescription: Int!
	//var placesSecondIndexImage: UIImage!
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
	setTitleForNotification()
	

	
	//setPlacesValues()

      }
	
	
	

	func setTitleForNotification(){
		
		if(indexValueSecond == 0){
			self.title = "RESTAURANT"
		}
		else if(indexValueSecond == 1){
			self.title = "ENTERTAINMENT"
		}
		else if(indexValueSecond == 2){
			self.title = "PUBS"
		}
		else if(indexValueSecond == 3){
			self.title = "CAFE"
		}
		else if(indexValueSecond == 4){
			self.title = "STORES"
		}
		else {
			self.title = "MEDICAL"
		}

	}
	
	
	
	
		
		
		
	func getImageFromArray(_ placeArrayForImage: [Places]){
		
		
		for index in 0..<restaurantValues.count {
			var photoLinkArray = restaurantValues[index].photoLink.characters.split{$0 == ","}.map(String.init)
			if(photoLinkArray.count > 0){
			let imageURL = URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(restaurantValues[index].placeId ?? "")/\(photoLinkArray[0] ).png")
			if let url = imageURL {
				var image: UIImage!
				//All network operations has to run on different thread(not on main thread).
				DispatchQueue.global(qos: .userInitiated).async {
					let imageData = NSData(contentsOf: url)
					//All UI operations has to run on main thread.
					DispatchQueue.main.async {
						if imageData != nil {
							image = UIImage(data: imageData! as Data)
							restaurantValues[index].placeImage = image
							//self.do_table_refresh()
							
						} else {
							image = nil
						}
					}
				}
				
			}
		}
		}
		DispatchQueue.main.async(execute: {self.do_table_refresh()})

		
		
	
	}
	


	
	
	
	func  do_table_refresh(){
		
		self.tableView.reloadData()
		
	}
	
	
	func checkValue(idValue: String,arrayName array: [Places])-> Bool
	{
		for i in 0..<array.count{
			if array[i].placeId == idValue{
				return false
			}
		}
		return true
		
	}
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
	
	
	  if(indexValueSecond == 0){
		  return restaurantValues.count
	  }
	  else if(indexValueSecond == 1){
		  return EntertainmentValues.count
	  }
	  else if(indexValueSecond == 2){
		  return pubsValues.count
	  }
	  else if(indexValueSecond == 3){
		  return cafeValues.count
	  }
	  else if(indexValueSecond == 4){
		  return storesValues.count
	  }
	  else {
		  return MedicalValues.count
	  }
	
	
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesfirsttvc", for: indexPath) as! PlacesFirstTVCell

	if(indexValueSecond == 0){
		updateValues(restaurantValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 1){
		updateValues(EntertainmentValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 2){
		updateValues(pubsValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 3){
		updateValues(cafeValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 4){
		updateValues(storesValues, cellForRow: indexPath, TableCell: cell)
	}
	else {
		updateValues(MedicalValues, cellForRow: indexPath, TableCell: cell)
	}

        return cell
    }
	
	
	func updateValues(_ valueForPlaces:[Places],cellForRow indexPath: IndexPath, TableCell TVcell:PlacesFirstTVCell ){
		
		TVcell.placeName!.text = valueForPlaces[indexPath.row].placeName
		TVcell.placceType!.text = valueForPlaces[indexPath.row].placeType
		TVcell.placeRating!.text = valueForPlaces[indexPath.row].placeRating
		TVcell.placeRating.text?.append("★")
		
		if(valueForPlaces[indexPath.row].placeFirstImageUrl != nil){

	
			TVcell.placeImage.kf.setImage(with: valueForPlaces[indexPath.row].placeFirstImageUrl)
		} else {
			print("Add the default image on places")
		}
		TVcell.placeDistance!.text = valueForPlaces[indexPath.row].placeDistance

		
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//indexValuePlacesDescription = indexPath.row
		let indexPathValues = tableView.indexPathForSelectedRow
		
		if(indexValueSecond == 0){
			updateValuesForSegue(restaurantValues, cellForRow: indexPathValues!)
		}
		else if(indexValueSecond == 1){
			updateValuesForSegue(EntertainmentValues, cellForRow: indexPathValues!)
		}
		else if(indexValueSecond == 2){
			updateValuesForSegue(pubsValues, cellForRow: indexPathValues!)
		}
		else if(indexValueSecond == 3){
			updateValuesForSegue(cafeValues, cellForRow: indexPathValues!)
		}
		else if(indexValueSecond == 4){
			updateValuesForSegue(storesValues, cellForRow: indexPathValues!)
		}
		else {
			updateValuesForSegue(MedicalValues, cellForRow: indexPathValues!)
		}
		
		
		self.performSegue(withIdentifier: "PlacesSecondaryVC", sender: self)
	}
	
	
	
	func updateValuesForSegue(_ valueForPlaces:[Places],cellForRow indexPath: IndexPath ){
		
		let indexPath = tableView.indexPathForSelectedRow
		//let currentCell = tableView.cellForRow(at: indexPath!) as! PlacesRestaurantTVCell
		//place1.placeImage = placesSecondIndexImage   //valueForPlaces[(indexPath?.row)!].placeImage
		place1.placeName = valueForPlaces[(indexPath?.row)!].placeName
		place1.placeAddress = valueForPlaces[(indexPath?.row)!].placeAddress
		place1.placeDescription = valueForPlaces[(indexPath?.row)!].placeDescription
		place1.placeDistance = valueForPlaces[(indexPath?.row)!].placeDistance
		place1.placeRating = valueForPlaces[(indexPath?.row)!].placeRating
		place1.phoneNumber = valueForPlaces[(indexPath?.row)!].phoneNumber
		place1.mapURL = valueForPlaces[(indexPath?.row)!].mapURL
		place1.placeType = valueForPlaces[(indexPath?.row)!].placeType
		place1.photoLink = valueForPlaces[(indexPath?.row)!].photoLink
		place1.placeFirstImageUrl = valueForPlaces[(indexPath?.row)!].placeFirstImageUrl
		place1.placeSecondImageUrl = valueForPlaces[(indexPath?.row)!].placeSecondImageUrl
	}


	
	
	
		
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	if (segue.identifier == "PlacesSecondaryVC") {
		// placesSecondaryVC
		let placesSecondaryVC = segue.destination as! PlacesSecondaryVC
		
		
		placesSecondaryVC.name = place1.placeName
		placesSecondaryVC.address = place1.placeAddress
		placesSecondaryVC.placeDescriptionValue = place1.placeDescription
		placesSecondaryVC.distance = place1.placeDistance
		placesSecondaryVC.rating = place1.placeRating
		placesSecondaryVC.placeTypeValue = "Restaurant"
		placesSecondaryVC.placePhoneNumber = place1.phoneNumber
		placesSecondaryVC.mapURL = place1.mapURL
		placesSecondaryVC.placeImageImg = place1.placeImage
		placesSecondaryVC.placeImgDesc = place1.image1
		placesSecondaryVC.titleNotification = place1.placeType
		placesSecondaryVC.photoLink = place1.photoLink
		placesSecondaryVC.mainUrl = place1.placeFirstImageUrl
		placesSecondaryVC.secondaryUrl = place1.placeSecondImageUrl
		
	}
	
    }
	

}
