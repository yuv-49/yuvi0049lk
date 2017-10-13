//
//  EventsIndividualVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 07/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class EventsIndividualVC: UIViewController {
	
	
	@IBOutlet weak var eventImage: UIImageView!
	@IBOutlet weak var eventLogo: UIImageView!
	@IBOutlet weak var eventHostedBy: UILabel!
	@IBOutlet weak var eventFee: UILabel!
	@IBOutlet weak var eventName: UILabel!
	@IBOutlet weak var dateAndTime: UILabel!
	@IBOutlet weak var daysLeft: UILabel!
	@IBOutlet weak var hoursLeft: UILabel!
	@IBOutlet weak var minuteLeft: UILabel!
	@IBOutlet weak var secondsLeft: UILabel!
	@IBOutlet weak var eventDescription: UILabel!
	@IBOutlet weak var eventAddress: UILabel!
	
	
	var myTimer : Timer!
	
	var receiverEventValues = homeEvents()

	var timeVals: Int!

	

    override func viewDidLoad() {
        super.viewDidLoad()

	updateUI()
	setDateAndTime()
	
	}

	
	func updateUI(){
		
		if let link = URL(string: receiverEventValues.eventImageLink)
		{
			eventImage.kf.setImage(with: link)
		
		}
		if let link1 = URL(string: receiverEventValues.eventLogo)
		{
			eventLogo.kf.setImage(with: link1)
		}
		eventHostedBy.text = receiverEventValues.eventHostedBy
		eventFee.text = "₹ \(receiverEventValues.eventFee!)"
		eventName.text = receiverEventValues.eventName
		eventDescription.text = receiverEventValues.eventDesc
		eventAddress.text = receiverEventValues.eventAddress
		
		
		
		
	}
	
	
	
	func setDateAndTime(){
		
		let dateSelected = receiverEventValues.eventDate
		let timeSelected = receiverEventValues.eventTime
		
		var meridian: String!
		
		
		
		
		var  timeBreak = timeSelected?.characters.split{$0 == ":"}.map(String.init)
		var dateBreak = dateSelected?.characters.split{$0 == "-"}.map(String.init)
		
		
		meridian = "AM"
		if Int((timeBreak?[0])!)! > 12 {
			timeVals = Int((timeBreak?[0])!)! - 12
			meridian = "PM"
		}else {
			timeVals = Int((timeBreak?[0])!)!
		}
		
		
		if Int((dateBreak?[1])!) == 1 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) JAN  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 2 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) FEB  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 3 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) MAR  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 4 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) APR  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 5 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) MAY  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 6 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) JUN  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 7 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) JUL  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 8 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) AUG  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 9 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) SEP  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 10 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) OCT  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 11 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) NOV  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}else if Int((dateBreak?[1])!) == 12 {
			dateAndTime.text = "\(String(describing: dateBreak?[2] ?? "")) DEC  \(String(describing: timeBreak?[0] ?? "")):\(String(describing: timeBreak?[1] ?? "")) \(meridian!)"
		}
		
		
		
		
		
	}

	
	
	
	override func viewDidAppear(_ animated: Bool) {
		
		_ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: false);
		
		
		
		
		 myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true);

		
		
		
			}
	
	override func viewDidDisappear(_ animated: Bool) {
		myTimer.invalidate()

	}
	
	
	func timerUpdate(){
		
		
		
		
		let dateToSubstract = receiverEventValues.eventDate
		let timeToSubstract = receiverEventValues.eventTime
		
		let date = Date()
		
		let calender = Calendar.current
		let hour = calender.component(.hour, from: date)
		let minute = calender.component(.minute, from: date)
		let second = calender.component(.second, from: date)
		let day = calender.component(.day, from: date)
		
		var  hourToSubstract = timeToSubstract?.characters.split{$0 == ":"}.map(String.init)
		let finalHourToSubstract = hourToSubstract?[0]
		
		var diffInHour = Int(finalHourToSubstract!)! + 24 - Int(hour)
		if diffInHour >= 24 {
			
			diffInHour -= 25
            
		}
        
        if diffInHour == -1{
            diffInHour = 0
        }
		print(diffInHour)
        
        if diffInHour < 10{
            
            hoursLeft.text = "0\(diffInHour)"
        }else{
            
            hoursLeft.text = "\(diffInHour)"
        }
        
		
		
		
		let finalMninuteToSubstract = hourToSubstract?[1]
		
		var diffInMinute = Int(finalMninuteToSubstract!)! + 60 - Int(minute)
		if diffInMinute >= 60 {
			
			diffInMinute -= 61
		}
        
        if diffInMinute == -1 {
            diffInMinute = 0
        }
		print(diffInMinute)
        
        if diffInMinute < 10{
            
            minuteLeft.text = ": 0\(diffInMinute)"
        }else{
            
            minuteLeft.text = ": \(diffInMinute)"
        }
        
        
        
		
		
		let finalSecondToSubstract = hourToSubstract?[2]
		
		var diffInSecond = Int(finalSecondToSubstract!)! + 60 - Int(second)
		if diffInSecond >= 60 {
			
			diffInSecond -= 60
		}
		print(diffInSecond)
        
        if diffInSecond < 10{
            secondsLeft.text = ": 0\(diffInSecond)"
        }else{
            secondsLeft.text = ": \(diffInSecond)"
            
        }
//		secondsLeft.text = ": \(diffInSecond)"
		
		
		var  datesVal = dateToSubstract?.characters.split{$0 == "-"}.map(String.init)
		let finalDayVal = datesVal?[2]
		
		var diffInDay = Int(finalDayVal!)! + 30 - Int(day)
		if diffInDay >= 30 {
			
			diffInDay -= 30
		}
		
	//	diffInDay -= 1
        if diffInDay == -1{
            diffInDay = 0
        }
		
		print(diffInDay)
        
        if diffInDay < 10{
            daysLeft.text = "0\(diffInDay)"
        }else{
            daysLeft.text = "\(diffInDay)"

        }

		

	}
	
	
	
	
	
	
	@IBAction func contactOrganiser(_ sender: Any) {
		
		
		
		
		
		if let phone = receiverEventValues.eventPhoneNumber{
			let newString = phone.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
			callNumber(phoneNumber: newString )
		}else{
			print("sorry no contact available")
			let alert = UIAlertController(title: "Not Available", message: "", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			
		}
	}
	
	private func callNumber(phoneNumber:String) {
		if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
			let application:UIApplication = UIApplication.shared
			if (application.canOpenURL(phoneCallURL)) {
				application.open(phoneCallURL, options: [:], completionHandler: nil)
			}
		}
	}
	
	
	
	@IBAction func purchaseTicket(_ sender: Any) {
		
		if receiverEventValues.eventWebsite != "" {
			
			
			if #available(iOS 10.0, *) {
				UIApplication.shared.open(NSURL(string: receiverEventValues.eventWebsite)! as URL, options: [:], completionHandler: nil)
			} else {
				UIApplication.shared.openURL(NSURL(string: receiverEventValues.eventWebsite)! as URL)
			}
			
			
			
			
			
			
			
			//UIApplication.shared.openURL(NSURL(string: receiverEventValues.eventWebsite)! as URL)

		}else{
			// call segue
			
			print("add the payment method")
		}
		
		
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
