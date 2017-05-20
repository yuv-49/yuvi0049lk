//
//  ConfirmOrderVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 05/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import BEMCheckBox


class ConfirmOrderVC: UIViewController, BEMCheckBoxDelegate , UITextFieldDelegate{
	
	
	
	
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
	
	
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
	
	
//	var myCheckBox = BEMCheckBox(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(25), height: CGFloat(25)))
//	view.addSubview(myCheckBox)
	
	
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

	}
	
	
	
	

	
	

    }
	func checkOut(_ sender:UITapGestureRecognizer){
		apiCall()
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
		var val = 0
		if  val == 1 {
			self.card.isHidden = true
			self.cardLabel.isHidden = true
			
			
		} else if val == 2 {
			self.cod.isHidden = true
			self.codLabel.isHidden = true
		} else if val == 3{
			
			
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
	
	
	
	
	func apiCall(){
		
		// MARK:- Api call for plcaing order
		
		var place = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v22.php?method=placeOrder")!)
		place.httpMethod = "POST"
	  let  postValue="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d&place_id=\(placeId!)&item_ids=\(cnfItemId!)&item_names=\(cnfItemName!)&item_quantity=\(cnfItemQuantity!)&total_cost=\(totalCost!)&address=\(userDeliveryAddress.text!)&user_phone=\(userPhoneNo.text!)&conv_fee=\(convFee!)&delivery=\(delivery!)&type=\(1)&item_cost=\(itemCost!)"
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
	

	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
