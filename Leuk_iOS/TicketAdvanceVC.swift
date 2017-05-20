//
//  TicketAdvanceVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class TicketAdvanceVC: UIViewController {
	
	
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var time: UILabel!
	@IBOutlet weak var eventName: UILabel!
	@IBOutlet weak var totalCost: UILabel!
	@IBOutlet weak var Host: UILabel!
	@IBOutlet weak var ticketCode: UILabel!
	@IBOutlet weak var allows: UILabel!
	@IBOutlet weak var location: UILabel!
	@IBOutlet weak var address: UILabel!
	
	@IBOutlet weak var ticketView: UIView!
	
	@IBOutlet weak var imageofPlace: UIImageView!
	
	
	

	var tickerReceiver = MyTicket()

    override func viewDidLoad() {
        super.viewDidLoad()

	
	
	updateUI()
	
	
	//applyZigZagEffect(givenView: ticketView)
	
	
	
	
	
	
	}

	
	
	func updateUI(){
		
		self.date.text = tickerReceiver.eventDate
		//self.time.text = "| \(tickerReceiver.eventTime!)"
		self.eventName.text = tickerReceiver.eventName
		self.totalCost.text = "₹ \(tickerReceiver.fee!)"
		self.Host.text = tickerReceiver.eventHost
		self.ticketCode.text = tickerReceiver.eventId
		self.allows.text = tickerReceiver.allows
		self.location.text = tickerReceiver.eventLocation
		self.address.text = tickerReceiver.eventAddress
		
		var timeForUI = tickerReceiver.eventTime.characters.split{$0 == ":"}.map(String.init)
		self.time.text = "| \(timeForUI[0]):\(timeForUI[1])"
		//cell.placeImage.kf.setImage(with: myOrdersYet[indexPath.row].imageLink)
		
		
		let url1 = URL(string: tickerReceiver.imageLink)
		self.imageofPlace.kf.setImage(with: url1)
		
	}
	
	
	
	
	
	
	
	@IBAction func previewTicket(_ sender: Any) {
		
	}
	
	
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
