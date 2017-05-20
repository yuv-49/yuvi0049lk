//
//  CartVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 05/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class CartVC: UIViewController , UITableViewDelegate, UITableViewDataSource, RazorpayPaymentCompletionProtocol {

	
	
	@IBOutlet weak var checkout: UIView!
	
	@IBOutlet weak var myTable: UITableView!
	@IBOutlet weak var minimalOrder: UILabel!
	@IBOutlet weak var deliveryCharge: UILabel!
	@IBOutlet weak var convenienceFee: UILabel!
	@IBOutlet weak var subtotal: UILabel!
	
	var addBtnClicked: Bool!
	var showHere : Int!

	private var razorpay : Razorpay!
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
	print(YOUR_PUBLIC_KEY)
	
	 razorpay = Razorpay.initWithKey("YOUR_PUBLIC_KEY", andDelegate: self)
	
	
	
	let gestureForCheckout = UITapGestureRecognizer(target: self, action:  #selector (self.checkOut1 (_:)))
	self.checkout.addGestureRecognizer(gestureForCheckout)
	
	addBtnClicked = false
	
	getGrandTotal()
	
	
	
	
	
	}

	func checkOut1(_ sender:UITapGestureRecognizer){
		
		self.performSegue(withIdentifier: "ConfirmOrderVC", sender: self)

		
		
	}
	func checkOut(_ sender:UITapGestureRecognizer){
		
		
		
		
		getGrandTotal()
		let min = cartValues[0].minimumSpending!

		if showHere > Int(min)! {
			let amount = showHere * 100
			print(amount)
			let options: [AnyHashable: Any] = ["amount": "\(amount)",     // mandatory, in paise
				// all optional other than amount.
				// "image": "https://url-to-image.png",
				"name": "webloom solutions",
				"description": "food",
				"prefill": ["email": "shashankjha1994@gmail.com",
				            "contact": "7795122355"],
				"theme": ["color": "#F37254"]]
			razorpay.open(options)
			
		} else {
			print("select minimum atleast")
			
		}
		
		
		
	
		
		
		
	}
	
	//MARK:- Razorpay delegates
	
	func onPaymentSuccess(_ payment_id: String) {
		UIAlertView.init(title: "Payment Successful", message: payment_id, delegate: self, cancelButtonTitle: "OK").show()
	}
	
	func onPaymentError(_ code: Int32, description str: String) {
		UIAlertView.init(title: "Error", message: str, delegate: self, cancelButtonTitle: "OK").show()
	}
	
	
	
	func getGrandTotal(){
		showHere = 0
		
		for cart in cartValues {
			
			showHere = showHere +  (cart.rows * Int(cart.itemOfferCost)!)
		}

		let min = cartValues[0].minimumSpending!
		deliveryCharge.text = cartValues[0].deliveryCharge!
		convenienceFee.text = cartValues[0].convFee!
		let subTotalValue = showHere + Int(cartValues[0].deliveryCharge)! + Int(cartValues[0].convFee)!
		subtotal.text = "\(subTotalValue)"
		
		if showHere > Int(min)! {
			minimalOrder.isHidden = true
			//subtotal.text = "\(showHere!)"
			print(showHere)
			
		} else {
			minimalOrder.isHidden = false
			minimalOrder.text = min
			
		}
		
		
		
	}


	
	
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cartValues.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
		
		
		cell.itemName.text = cartValues[indexPath.row].itemName
		cell.itemCost.text = cartValues[indexPath.row].itemOfferCost
		
		cell.addItem.tag = indexPath.row
		cell.addItem.addTarget(self, action: #selector(self.addItem(_:)), for: .touchUpInside)
		cell.substractItem.tag = indexPath.row
		cell.substractItem.addTarget(self, action: #selector(self.deleteItem(_:)), for: .touchUpInside)
		
		let link = URL(string: cartValues[indexPath.row].itemImageLink)!
		cell.itemImage.kf.setImage(with: link)

		
		
		cell.numberOfItems.text = "\(cartValues[indexPath.row].rows!)"

		if addBtnClicked {
			
			cell.numberOfItems.text = "\(cartValues[indexPath.row].rows!)"
			getGrandTotal()
			addBtnClicked = false
		}
		
		
		
		
		
		
		return cell
	}
	
	
	
	
	
	func addItem(_ button: UIButton) {
		let clicked = button.tag
		
		cartValues[clicked].rows = cartValues[clicked].rows + 1
		
		
		
		
		
		
		addBtnClicked = true
		
		
		let indexPath = IndexPath(item: button.tag, section: 0)
		myTable.reloadRows(at: [indexPath], with: .none)

	}
	
	
	func deleteItem(_ button: UIButton) {
		let clicked = button.tag
		
		var sum = 0
		cartValues[clicked].rows = cartValues[clicked].rows - 1
		if cartValues[clicked].rows <= 0 {
			cartValues.remove(at: clicked)
			sum = 1
		}

		
		
		addBtnClicked = true
		
		
		
		if sum == 1 {
			myTable.reloadData()
			
		} else {
			let indexPath = IndexPath(item: button.tag, section: 0)
			myTable.reloadRows(at: [indexPath], with: .none)
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	
	if (segue.identifier == "ConfirmOrderVC") {
		
		let shopMenuVC = segue.destination as! ConfirmOrderVC
		shopMenuVC.entryPoint = 1
		
		
		
		
	}

	
	
	
	
	
	
	
	
	
	
	}
	

}
