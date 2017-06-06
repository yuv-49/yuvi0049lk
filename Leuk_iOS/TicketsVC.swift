//
//  EventsVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftyJSON


// Also known as tickets,coz u know....



class TicketsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var myCollectionView: UICollectionView!
	
	class func instantiateFromStoryboard() -> TicketsVC {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "eventsvc") as! TicketsVC
	}

	
	
	
	
	var myTicketYet = [MyTicket]()
	var ticketSender = MyTicket()
	
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

	
	apiCall()
	
	

	
	
    }

	
	func apiCall(){
		
		
		// MARK:- PROFILE MYTICKETS
		
		var myTickets = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=myTickets")!)
		myTickets.httpMethod = "POST"
		let postStringForTickets="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)"
		print("\(postStringForTickets)")
		
		
		myTickets.httpBody = postStringForTickets.data(using: .utf8)
		
		let taskForTickets = URLSession.shared.dataTask(with: myTickets) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				//print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				let json = JSON(data: data!)
				print(json)
				let numberOfEvents =  json["response"]["data"].count
				print(numberOfEvents)
				if numberOfEvents > 0
				{
					for index in 0...numberOfEvents - 1 {
						
						
						
						
						if json["response"]["data"][index]["id"].string != nil{

						let myTicketData = MyTicket()
						myTicketData.allows = json["response"]["data"][index]["allows"].string!
						myTicketData.eventAddress = json["response"]["data"][index]["address"].string!
						myTicketData.eventCategory = json["response"]["data"][index]["category"].string!
						myTicketData.eventDate = json["response"]["data"][index]["date"].string!
						myTicketData.eventDesc = json["response"]["data"][index]["description"].string!
						myTicketData.eventHost = json["response"]["data"][index]["hosted_by"].string!
						myTicketData.eventId = json["response"]["data"][index]["id"].string!
						myTicketData.eventLat = json["response"]["data"][index]["latitude"].string!
						myTicketData.eventLogo = json["response"]["data"][index]["logo"].string!
						myTicketData.eventLong = json["response"]["data"][index]["longitude"].string!
						myTicketData.eventName = json["response"]["data"][index]["name"].string!
						myTicketData.eventPhone = json["response"]["data"][index]["phone"].string!
						myTicketData.eventTime = json["response"]["data"][index]["time"].string!
						myTicketData.eventViews = json["response"]["data"][index]["views"].string!
						myTicketData.imageLink = json["response"]["data"][index]["image_link"].string!
						myTicketData.statusCode = json["response"]["data"][index]["status"].string!
						myTicketData.ticketBasecode = json["response"]["data"][index]["ticket_basecode"].string!
						//myTicketData.ticketCode = json["response"]["data"][index]["ticket_code"].string!
						myTicketData.ticketLimit = json["response"]["data"][index]["ticket_limit"].string!
						myTicketData.ticketSales = json["response"]["data"][index]["ticket_sales"].string!
						myTicketData.fee = json["response"]["data"][index]["fee"].string!
						myTicketData.eventLocation = json["response"]["data"][index]["location"].string!
						myTicketData.ticketId = json["response"]["data"][index]["ticket_id"].string!
							
						var finalString: String!
						var timeForUI = myTicketData.eventTime.characters.split{$0 == ":"}.map(String.init)
						
						if Int(timeForUI[0])! > 12 {
							
							let hour = Int(timeForUI[0])! - 12
							finalString =  "\(hour):\(timeForUI[1]) PM"
							
							
						}else{
							finalString =  "\(timeForUI[0]):\(timeForUI[1]) AM"
						}
						
						
						
						
						myTicketData.finalTime = finalString
						
						
						
						
						
						//var dateObtained = myTicketData.eventDate.characters.split(separator: $0 == " ")
						
						
						
						
//						
//						
//						orderOnce.imageLink = URL(string: "https://leuk.xyz/leukapi12345/images/gurgaon/\(orderOnce.placeId ?? "")/\(orderOnce.photoForOrder ?? "" ).png")!
//						
//						
//						var  dateObtained = orderOnce.timeStamp.characters.split{$0 == " "}.map(String.init)
//						self.date = "\(dateObtained[1] ) \(dateObtained[2] ) \(dateObtained[3] )"
//						print(self.date)
//						orderOnce.date = self.date
//						
//						var meridian = "AM"
//						var hourValueSoft: Int!
//						var timeObtained = dateObtained[4].characters.split{$0 == ":"}.map(String.init)
//						if Int(timeObtained[0])! > 12 {
//							hourValueSoft = Int(timeObtained[0])! - 12
//							meridian = "PM"
//						}else{
//							hourValueSoft = Int(timeObtained[0])!
//						}
//						self.time = "\(hourValueSoft!):\(timeObtained[1]) \(meridian)"
//						orderOnce.time = self.time
//						
//						print(self.time)
						
						
						
							self.myTicketYet.append(myTicketData)

						}
				
				
				
					}
				}
				
				
				
				
				
				
				
				
				
				
				
//				let index = 0
//				
//				
//				
//				
//				orderDetailsForUser.placeId = json["response"]["data"][index]["id"].string!
//				orderDetailsForUser.placeName = json["response"]["data"][index]["name"].string!
//				orderDetailsForUser.placeType = json["response"]["data"][index]["type"].string!
//				let lat = json["response"]["data"][index]["latitude"].string!
				
				
				

			}
		}
		
		taskForTickets.resume()

		
		
		
		
		
	}
	
	
	
	

	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if myTicketYet.count == 0{
			_ = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: false);
		}
		return myTicketYet.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! TicketsVCell
		
		
		cell.orderDate.text = myTicketYet[indexPath.row].eventDate
		cell.orderTime.text = myTicketYet[indexPath.row].finalTime
		cell.organiserCommitee.text = myTicketYet[indexPath.row].eventHost
		cell.quantity.text = "X \(myTicketYet[indexPath.row].allows!)"
		cell.totalCharge.text = myTicketYet[indexPath.row].fee
		cell.EventName.text = myTicketYet[indexPath.row].eventName
		let url = URL(string: myTicketYet[indexPath.row].imageLink)
		cell.placeImage.kf.setImage(with: url)
		
		

		
		
		return cell

	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		ticketSender.allows = myTicketYet[indexPath.row].allows
		ticketSender.eventAddress = myTicketYet[indexPath.row].eventAddress
		ticketSender.eventCategory = myTicketYet[indexPath.row].eventCategory
		ticketSender.eventDate = myTicketYet[indexPath.row].eventDate
		ticketSender.eventDesc = myTicketYet[indexPath.row].eventDesc
		ticketSender.eventHost = myTicketYet[indexPath.row].eventHost
		ticketSender.eventId = myTicketYet[indexPath.row].eventId
		ticketSender.eventLat = myTicketYet[indexPath.row].eventLat
		ticketSender.eventLogo = myTicketYet[indexPath.row].eventLogo
		ticketSender.eventLong = myTicketYet[indexPath.row].eventLong
		ticketSender.eventName = myTicketYet[indexPath.row].eventName
		ticketSender.eventPhone = myTicketYet[indexPath.row].eventPhone
		//ticketSender.eventTime = myTicketYet[indexPath.row].eventTime
		ticketSender.eventViews = myTicketYet[indexPath.row].eventViews
		ticketSender.fee = myTicketYet[indexPath.row].fee
		ticketSender.finalTime = myTicketYet[indexPath.row].finalTime
		ticketSender.imageLink = myTicketYet[indexPath.row].imageLink
		ticketSender.statusCode = myTicketYet[indexPath.row].statusCode
		ticketSender.ticketBasecode = myTicketYet[indexPath.row].ticketBasecode
		ticketSender.ticketCode = myTicketYet[indexPath.row].ticketCode
		ticketSender.ticketLimit = myTicketYet[indexPath.row].ticketLimit
		ticketSender.ticketSales = myTicketYet[indexPath.row].ticketSales
		ticketSender.eventLocation = myTicketYet[indexPath.row].eventLocation
		ticketSender.eventTime = myTicketYet[indexPath.row].eventTime
		ticketSender.ticketId = myTicketYet[indexPath.row].ticketId
		
		self.performSegue(withIdentifier: "TicketAdvanceVC", sender: self)
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	func updateView(){
		
		if myTicketYet.count == 0{
			_ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateView), userInfo: nil, repeats: false);
			
		}
		myCollectionView.reloadData()
		
	}
	
	
	
	
	
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	
	
	
	
	
	if (segue.identifier == "TicketAdvanceVC")
	{
		
		let ticketValues = segue.destination as! TicketAdvanceVC
		

		
		
		ticketValues.tickerReceiver.allows = ticketSender.allows
		ticketValues.tickerReceiver.eventAddress = ticketSender.eventAddress
		ticketValues.tickerReceiver.eventCategory = ticketSender.eventCategory
		ticketValues.tickerReceiver.eventDate = ticketSender.eventDate
		ticketValues.tickerReceiver.eventDesc = ticketSender.eventDesc
		ticketValues.tickerReceiver.eventHost = ticketSender.eventHost
		ticketValues.tickerReceiver.eventId = ticketSender.eventId
		ticketValues.tickerReceiver.eventLat = ticketSender.eventLat
		ticketValues.tickerReceiver.eventLogo = ticketSender.eventLogo
		ticketValues.tickerReceiver.eventLong = ticketSender.eventLong
		ticketValues.tickerReceiver.eventName = ticketSender.eventName
		ticketValues.tickerReceiver.eventPhone = ticketSender.eventPhone
		//ticketSender.eventTime = myTicketYet[indexPath.row].eventTime
		ticketValues.tickerReceiver.eventViews = ticketSender.eventViews
		ticketValues.tickerReceiver.fee = ticketSender.fee
		ticketValues.tickerReceiver.finalTime = ticketSender.finalTime
		ticketValues.tickerReceiver.imageLink = ticketSender.imageLink
		ticketValues.tickerReceiver.statusCode = ticketSender.statusCode
		ticketValues.tickerReceiver.ticketBasecode = ticketSender.ticketBasecode
		ticketValues.tickerReceiver.ticketCode = ticketSender.ticketCode
		ticketValues.tickerReceiver.ticketLimit = ticketSender.ticketLimit
		ticketValues.tickerReceiver.eventLocation = ticketSender.eventLocation
		ticketValues.tickerReceiver.eventTime = ticketSender.eventTime
		ticketValues.tickerReceiver.ticketId = ticketSender.ticketId
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
    }
	

}
