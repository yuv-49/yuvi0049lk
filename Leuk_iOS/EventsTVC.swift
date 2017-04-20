//
//  EventsTVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class EventsTVC: UITableViewController {
	var indexValueSecond: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

	
	setTitleForNotification()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	
	func setTitleForNotification(){
		
		if(indexValueSecond == 0){
			self.title = "F&B"
		}
		else if(indexValueSecond == 1){
			self.title = "SOCIAL"
		}
		else if(indexValueSecond == 2){
			self.title = "STARTUPS"
		}
		else if(indexValueSecond == 3){
			self.title = "SPORTS"
		}
		else if(indexValueSecond == 4){
			self.title = "MEETUPS"
		}
		else {
			self.title = "PARTIES"
		}
		
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
		return foodValues.count
	}
	else if(indexValueSecond == 1){
		return socialValues.count
	}
	else if(indexValueSecond == 2){
		return startupValues.count
	}
	else if(indexValueSecond == 3){
		return sportsValues.count
	}
	else if(indexValueSecond == 4){
		return meetupValues.count
	}
	else {
		return partyValues.count
	}

    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventstvcell", for: indexPath) as! EventsTVCell

	if(indexValueSecond == 0){
		updateValues(foodValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 1){
		updateValues(socialValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 2){
		updateValues(startupValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 3){
		updateValues(sportsValues, cellForRow: indexPath, TableCell: cell)
	}
	else if(indexValueSecond == 4){
		updateValues(meetupValues, cellForRow: indexPath, TableCell: cell)
	}
	else {
		updateValues(partyValues, cellForRow: indexPath, TableCell: cell)
	}


        return cell
    }
	
	func updateValues(_ valueForPlaces:[homeEvents],cellForRow indexPath: IndexPath, TableCell TVcell:EventsTVCell ){
		
		
		
		TVcell.name.text = valueForPlaces[indexPath.row].eventName
		TVcell.hostedBy.text = valueForPlaces[indexPath.row].eventHostedBy
		TVcell.date.text = valueForPlaces[indexPath.row].eventDate
		TVcell.time.text = valueForPlaces[indexPath.row].eventTime
		TVcell.imageLink.image = valueForPlaces[indexPath.row].eventImageOriginal
		let link = URL(string: valueForPlaces[indexPath.row].eventImageLink)!
		TVcell.imageLink.kf.setImage(with: link)
		let link2 = URL(string: valueForPlaces[indexPath.row].eventLogo)!
		TVcell.logo.kf.setImage(with: link2)
		
		
		

		
		
		
	}
	
	

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
