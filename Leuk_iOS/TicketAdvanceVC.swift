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
//	@IBOutlet weak var location: UILabel!
	@IBOutlet weak var address: UILabel!
//	@IBOutlet weak var ticketView: UIView!
//	@IBOutlet weak var imageofPlace: UIImageView!
	@IBOutlet weak var logo: UIImageView!
	@IBOutlet weak var imageQRCode: UIImageView!
	
	var tickerReceiver = MyTicket()
	var qrcodeImage: CIImage!

	
    override func viewDidLoad() {
        super.viewDidLoad()

	
	
	
	performButtonAction()
	
	updateUI()
	
	
	//applyZigZagEffect(givenView: ticketView)
	
	
	
	
	
	
	}
	
	
	func setCircularImage(){
		
		
//		image.layer.borderWidth=1.0
//		image.layer.masksToBounds = false
//		image.layer.borderColor = UIColor.whiteColor().CGColor
//		image.layer.cornerRadius = image.frame.size.height/2
//		image.clipsToBounds = true
		
	}

	
	
	
	
	
	
	
	
	func performButtonAction(){
		
		if qrcodeImage == nil {
			if tickerReceiver.ticketId == "" {
				return
			}
			
			let data = tickerReceiver.ticketId.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
			
			let filter = CIFilter(name: "CIQRCodeGenerator")
			
			filter?.setValue(data, forKey: "inputMessage")
			filter?.setValue("Q", forKey: "inputCorrectionLevel")
			
			qrcodeImage = filter?.outputImage
			
			displayQRCodeImage()

			//imageQRCode.image = UIImage(ciImage: qrcodeImage)
		}
		
	}
	
	func displayQRCodeImage() {
		let scaleX = imageQRCode.frame.size.width / qrcodeImage.extent.size.width
		let scaleY = imageQRCode.frame.size.height / qrcodeImage.extent.size.height
		
		let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
		
		imageQRCode.image = UIImage(ciImage: transformedImage)
		
		
	}
	
	
	
	func updateUI(){
		
		self.date.text = tickerReceiver.eventDate
		//self.time.text = "| \(tickerReceiver.eventTime!)"
		self.eventName.text = tickerReceiver.eventName
		self.totalCost.text = "₹ \(tickerReceiver.fee!)"
		self.Host.text = tickerReceiver.eventHost
		self.ticketCode.text = tickerReceiver.ticketId
		self.allows.text = tickerReceiver.allows
		//self.location.text = tickerReceiver.eventLocation
		self.address.text = tickerReceiver.eventAddress
		
		var timeForUI = tickerReceiver.eventTime.characters.split{$0 == ":"}.map(String.init)
		self.time.text = "| \(timeForUI[0]):\(timeForUI[1])"
		//cell.placeImage.kf.setImage(with: myOrdersYet[indexPath.row].imageLink)
		
		
//		let url1 = URL(string: tickerReceiver.imageLink)
//		self.imageofPlace.kf.setImage(with: url1)
		let url2 = URL(string: tickerReceiver.eventLogo)
		self.logo.kf.setImage(with: url2)
		self.logo.layer.cornerRadius = logo.frame.size.height/2
		self.logo.layer.borderWidth = 1.0
		
	}
	
	
	
	
	
	
	
//	@IBAction func previewTicket(_ sender: Any) {
		
		
		
//	}
	
	
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
