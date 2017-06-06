//
//  ConfirmOrderVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 05/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import BEMCheckBox
import SwiftyJSON


class ConfirmOrderVC: UIViewController, BEMCheckBoxDelegate , UITextFieldDelegate, RazorpayPaymentCompletionProtocol{
	
	
	
	
	@IBOutlet weak var card: BEMCheckBox!
	@IBOutlet weak var rememberMe: BEMCheckBox!
	@IBOutlet weak var totalAmount: UILabel!
	@IBOutlet weak var cod: BEMCheckBox!
	@IBOutlet weak var username: UITextField!
	@IBOutlet weak var userPhoneNo: UITextField!
	@IBOutlet weak var userDeliveryAddress: UITextField!
	@IBOutlet weak var proceedToPayment: UIView!
	@IBOutlet weak var estimatedTime: UILabel!
	
	@IBOutlet weak var codLabel: UILabel!
	@IBOutlet weak var cardLabel: UILabel!
	
	
	
	
	var entryPoint : Int!
	
	
	
	var itemId: String!
	var itemName: String!
	var itemQty: String!
	var showHere : Int!

	
	var cnfItemId: String!
	var placeId: String!
	var cnfItemName: String!
	var cnfItemQuantity : String!
	var totalCost: String!
	var address: String!
	var userPhone: String!
	var convFee: String!
	var delivery: String!
	var type: String!
	var itemCost: String!
	
	var subTotalValue : Int!
	
	var cardOrCod: Int!
	
	
	
	
	
	
	
	
	var razorpayOrderId: String!
	
	private var razorpay : Razorpay!
	
	
	
	
	
	
	
	
	
	
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
	
	
//	var myCheckBox = BEMCheckBox(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25)))
//	view.addSubview(myCheckBox)
	
	
	
	razorpay = Razorpay.initWithKey(YOUR_PUBLIC_KEY, andDelegate: self)
	
	
	
	cod.delegate = self
	card.delegate = self
	rememberMe.delegate = self
	cardOrCod = 0
	userPhoneNo.delegate = self
	username.delegate = self
	userDeliveryAddress.delegate = self
	
	cod.on = false
	card.on = false
	
	
	
		setUserDefaults()

	
	
	



	let gestureForCheckout = UITapGestureRecognizer(target: self, action:  #selector (self.checkOut (_:)))
	self.proceedToPayment.addGestureRecognizer(gestureForCheckout)
	


	
	showingAndRemoving()
	
	
	
	
	if entryPoint == 1 {
		totalCostFunc()

		getPlaceOrder()

	}else if entryPoint == 2 {
		
		subTotalValue = Int(myOrderreceiver.totalCost)! + Int(myOrderreceiver.convFee)! + Int(myOrderreceiver.deliveryCharge)!
		totalAmount.text = "\(subTotalValue!)"

		getPlaceOrderForLong()
		
		
	}
	
	
	
	

	
	

    }
	
	
	
	

	
	
	func checkOut(_ sender:UITapGestureRecognizer){
		
		
		
		
		
		if cardOrCod == 1 {
			apiCallForPlacingOrderFinal()
			
		}else if cardOrCod == 2 {
			
			let amount = subTotalValue * 100
			
			var place = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=generateOrderId")!)
			place.httpMethod = "POST"
			let  postValue="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&amount=\(amount)&order_type=\(cardOrCod!)"
			print("YSHSHSHSHSHSYSYSYSYS \(postValue)")
			
			
			place.httpBody = postValue.data(using: .utf8)
			
			let task2 = URLSession.shared.dataTask(with: place) { data, response, error in
				if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
					print("statusCode should be 200, but is \(httpStatus.statusCode)")
					//print("response = \(response)")
				}
					
				else {
					
					var json = JSON(data: data!)
					print(json)
					
					self.razorpayOrderId = json["response"]["data"]["razorpay_order_id"].string!
					
					
					
					
					
					
				}
			}
			
			task2.resume()

			callRazorpay()

		}
		

		
		
		
		
		
		
	}
	
	
	func callRazorpay(){
		
		if self.razorpayOrderId != nil {
			
			let amount = subTotalValue * 100
			print(amount)
			let options: [AnyHashable: Any] = ["amount": "\(amount)",     // mandatory, in paise
				// all optional other than amount.
				// "image": "https://url-to-image.png",
				"name": "webloom solutions",
				"currency": "INR",
				"order_id": "\(razorpayOrderId!)",
				"description": "food",
	// MARK:- fill these 			"prefill": ["email": "shashankjha1994@gmail.com",
	//			            "contact": "7795122355"],
				"theme": ["color": "#F37254"]]
			razorpay.open(options)
		}
	}
	
	
	
	
	
	//MARK:- Razorpay delegates
	
	func onPaymentSuccess(_ payment_id: String) {
		UIAlertView.init(title: "Payment Successful", message: payment_id, delegate: self, cancelButtonTitle: "OK").show()
	}
	
	func onPaymentError(_ code: Int32, description str: String) {
		UIAlertView.init(title: "Error", message: str, delegate: self, cancelButtonTitle: "OK").show()
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	func setUserDefaults(){
		
		
		if let nameValueForSaving = userDefaults.value(forKey: "nameValueForSaving") {
			username.text = nameValueForSaving as? String
		}
		if let phoneValueForSaving = userDefaults.value(forKey: "phoneValueForSaving") {
			userPhoneNo.text = phoneValueForSaving as? String
		}
		if let addressValueForSaving = userDefaults.value(forKey: "addressValueForSaving") {
			userDeliveryAddress.text = addressValueForSaving as? String
		}
		
	}
	
	
	
	func didTap(_ checkBox: BEMCheckBox) {
		
		
		if checkBox.tag == 1{
			cardOrCod = 1
			self.cod.on = true
			self.card.on = false
		}
		if checkBox.tag == 2{
			cardOrCod = 2
			self.card.on = true
			self.cod.on = false

			
		}
		if checkBox.tag == 3{
			let nameValueForSaving = username.text?.characters.count
			if nameValueForSaving != 0{
				userDefaults.set(username.text, forKey: "nameValueForSaving")
			}
			let phoneValueForSaving = userPhoneNo.text?.characters.count
			if phoneValueForSaving == 10 {
				userDefaults.set(userPhoneNo.text, forKey: "phoneValueForSaving")
			}
			let addressValueForSaving = userDeliveryAddress.text?.characters.count
			if addressValueForSaving != 0 {
				userDefaults.set(userDeliveryAddress.text, forKey: "addressValueForSaving")
			}
			
			print("hihiop3")

			
			
			
		}
	}
	
	func showingAndRemoving(){

		print("\( placeServiceStatusForPayment)")
		if  placeServiceStatusForPayment == 1 {
			self.card.isHidden = true
			self.cardLabel.isHidden = true
			self.cod.on = true
			cardOrCod = 1
			
			
		} else if placeServiceStatusForPayment == 2 {
			self.cod.isHidden = true
			self.codLabel.isHidden = true
			self.card.on = true
			cardOrCod = 2
		} else if placeServiceStatusForPayment == 3{
			
			
		}
	}
	
	
	
	func totalCostFunc(){
		
		showHere = 0
		
		for cart in cartValues {
			
			showHere = showHere +  (cart.rows * Int(cart.itemOfferCost)!)
		}
		
		subTotalValue = showHere + Int(cartValues[0].deliveryCharge)! + Int(cartValues[0].convFee)!
		totalAmount.text = "\(subTotalValue!)"

	}
	
	func getPlaceOrder(){
		
		placeId = cartValues[0].placeId
		totalCost = "\(subTotalValue!)"
		convFee = cartValues[0].convFee
		delivery = cartValues[0].deliveryCharge
		
		print("YSHS PLACEID \(placeId)")
		print("YSHS AMOUNT \(totalCost)")
		print("YSHS convfee \(convFee)")
		print("YSHS delivery \(delivery)")

		
		
		cnfItemId = "\(cartValues[0].itemId!)"
		cnfItemName = "\(cartValues[0].itemName!)"
		cnfItemQuantity = "\(cartValues[0].rows!)"
		itemCost = "\(cartValues[0].itemOfferCost!)"
		
		var i = 0
		for cart in cartValues {
			if i  > 0 {
				cnfItemId = cnfItemId + ",\(cart.itemId!)"
				cnfItemName = cnfItemName + ",\(cart.itemName!)"
				cnfItemQuantity = cnfItemQuantity + ",\(cart.rows!)"
				itemCost = itemCost + ",\(cart.itemOfferCost!)"
			}
			

			
			
			
			
			i += 1
			print(itemId)
		}
		print("YSHS ITEMIDS \(cnfItemId!)")
		print("YSHS ITEMNAMES \(cnfItemName!)")
		print("YSHS ITEMQTY \(cnfItemQuantity!)")
		print("YSHS itemcost \(itemCost!)")

		
	}
	
	func getPlaceOrderForLong(){
		
		placeId = myOrderreceiver.placeId
		totalCost = myOrderreceiver.totalCost
		convFee = myOrderreceiver.convFee
		delivery = myOrderreceiver.deliveryCharge
		
		cnfItemId = myOrderreceiver.itemIds
		cnfItemName = myOrderreceiver.itemNames
		cnfItemQuantity = myOrderreceiver.itemQuantity
		itemCost = myOrderreceiver.itemCost
		
		print("YSHS PLACEID \(placeId!)")
		print("YSHS AMOUNT \(totalCost!)")
		print("YSHS convfee \(convFee!)")
		print("YSHS delivery \(delivery!)")
		
		
		print("YSHS ITEMIDS \(cnfItemId!)")
		print("YSHS ITEMNAMES \(cnfItemName!)")
		print("YSHS ITEMQTY \(cnfItemQuantity!)")
		print("YSHS itemcost \(itemCost!)")
		
		
		
		
	}
	
	
	
	
	func apiCallForPlacingOrderFinal(){
		
		// MARK:- Api call for plcaing order
		
		
		//var totalFinalCost = totalCost + convFee + delivery
		
		var place = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=placeOrder")!)
		place.httpMethod = "POST"
	  let  postValue="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&sessionid=\(SESSION_ID!)&token=\(TOKEN_ID_FROM_LEUK!)&place_id=\(placeId!)&item_ids=\(cnfItemId!)&item_names=\(cnfItemName!)&item_quantity=\(cnfItemQuantity!)&total_cost=\(subTotalValue!)&address=\(userDeliveryAddress.text!)&user_phone=\(userPhoneNo.text!)&conv_fee=\(convFee!)&delivery=\(delivery!)&type=\(cardOrCod!)&item_cost=\(itemCost!)"
		print("YSHSHSHSHSHSYSYSYSYS \(postValue)")
		
		
		place.httpBody = postValue.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: place) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				print("order plcaed")
				UIAlertView.init(title: "Order SuccessFul", message: "your orderhas been successfully placed", delegate: self, cancelButtonTitle: "DONE").show()
				
				
			}
		}
		
		task2.resume()

		
		
		
	}
	
	
	
	
	
	
	
	
	
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		
		let clicked = textField.tag
		
		if clicked == 2{
		
		      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
		      let compSepByCharInSet = string.components(separatedBy: aSet)
		      let numberFiltered = compSepByCharInSet.joined(separator: "")
		      let newText = (userPhoneNo.text! as NSString).replacingCharacters(in: range, with: numberFiltered)
		      let numberOfChars = newText.characters.count // for Swift use count(newText)
		      if (string == "\n") {
			      textField.resignFirstResponder()
			      return false
		      }
		      return ((string == numberFiltered ) && (numberOfChars < 11))
		}
		if clicked == 1 || clicked == 3{
			if (string == "\n") {
				textField.resignFirstResponder()
				return false
			}
		}
		return true
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
