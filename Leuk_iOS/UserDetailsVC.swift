//
//  UserDetailsVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 23/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import BEMCheckBox
import SwiftyJSON


class UserDetailsVC: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource,  BEMCheckBoxDelegate , UITextFieldDelegate {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var emailId: UILabel!
	
	@IBOutlet weak var phoneNumber: UITextField!
	@IBOutlet weak var referralCode: UITextField!
	@IBOutlet weak var locationPicker: UIPickerView!
	@IBOutlet weak var male: BEMCheckBox!
	@IBOutlet weak var female: BEMCheckBox!
	
	
	@IBOutlet weak var BeginLoading: UILabel!
	
	
	var locationVal: String!
	var gender: Int!
	
	var name: String!
	var email: String!
	var userName: String!
	var profileImageValue: String!
	var token: String!

	
	
	var pickerDataSource = ["Manipal", "Bangalore", "Gurgaon", "Ranchi"]
	
	
	
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
	male.delegate =  self
	female.delegate = self
	male.on = false
	female.on = false
	
	phoneNumber.delegate = self
	referralCode.delegate = self

	self.locationPicker.dataSource = self;
	self.locationPicker.delegate = self;
	self.emailId.text = email
	locationVal = "Manipal"
	
	fetchImage()
	
	let gestureForCheckout = UITapGestureRecognizer(target: self, action:  #selector (self.callApi (_:)))
	self.BeginLoading.addGestureRecognizer(gestureForCheckout)

    }
	
	

	
	func fetchImage(){
		
		let url = URL(string: profileImageValue)
		profileImage.kf.setImage(with: url)
		
		
	}
	
	
	
	
	
	
	func callApi(_ sender:UITapGestureRecognizer){
		
		
		
		var counter = 0
		
		if let phoneNumberLocal = phoneNumber.text{
			
			if let gender = gender{
				
				if let locationVal = locationVal{
					
					profileDetailArray.name = name
					profileDetailArray.email = email
					profileDetailArray.userName = userName
					if gender == 1{
						
						profileDetailArray.gender = "Male"
						
					}else if gender == 2{
						profileDetailArray.gender = "female"
					}
					profileDetailArray.locaion = locationVal
					if referralCode.text != nil{
						profileDetailArray.referralCode = referralCode.text
					}else{
						profileDetailArray.referralCode = ""
					}
					profileDetailArray.phone = phoneNumberLocal
					profileDetailArray.profileImage = profileImageValue
					
					//MARK:- setting the optional value
					
					profileDetailArray.dob = ""
					profileDetailArray.password = ""
					
					
				      counter = 1
					
				}
			}
		}
		
		
		
		if counter == 0{
			print("something is missing")
		}else if counter == 1{
			
			print("proceed")
			
			apiCallForSignup()
		}
		
		

		
		
	}
	
	
	
	func apiCallForSignup(){
		
		
		//MARK:- Signup
		
		var newsRequest = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=signup")!)
		newsRequest.httpMethod = "POST"
		let postStringForNews="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&name=\(profileDetailArray.name!)&profile_img=\(profileDetailArray.profileImage!)&username=\(profileDetailArray.email!)&email=\(profileDetailArray.email!)&gender=\(profileDetailArray.gender!)&phone=\(profileDetailArray.phone!)&password=\(token!)&location=\(profileDetailArray.locaion!)&dob=\(profileDetailArray.dob!)&"
		print("\(postStringForNews)")
		
		
		newsRequest.httpBody = postStringForNews.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: newsRequest) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				
				
				let json = JSON(data: data!)
				print(json)
				
				DispatchQueue.main.async {
					self.apiCallForLogin()
				}
				
				
				
//				let numberOfEvents =  json["response"]["data"].count
//
//				//DispatchQueue.main.async {
//				countOfPagesForFirstPage = numberOfEvents
//				//}
//				
//				
//				
//				print(numberOfEvents)
//				if numberOfEvents > 0
//				{
//					for index in 0...numberOfEvents - 1 {
//						
//						let getNewsArray = PopularNews()
//						
//						getNewsArray.newsId = json["response"]["data"][index]["id"].string!
//						getNewsArray.imageLink = json["response"]["data"][index]["image_link"].string!
//						getNewsArray.newsTitle = json["response"]["data"][index]["news_title"].string!
//						getNewsArray.hits = json["response"]["data"][index]["hits"].string!
//						getNewsArray.newsSource = json["response"]["data"][index]["source"].string!
//						getNewsArray.pageLink = json["response"]["data"][index]["link"].string!
//						
//						
//						
//						
//						firstPageNews.append(getNewsArray)
//						
//						
//					}
//				}
			}
			
			
			
		}
		
		
		
		task2.resume()

		
		
		
		
	}
	
	
	
	
	
	func apiCallForLogin(){
		
		
		
		//MARK:- LOGIN
		
		var login = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=login")!)
		login.httpMethod = "POST"
		let postStringForNews="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&email=\(profileDetailArray.email!)&username=\(profileDetailArray.email!)&password=\(profileDetailArray.email!)"
		print("\(postStringForNews)")
		
		
		login.httpBody = postStringForNews.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: login) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
			}
				
			else {
				
				
				var json = JSON(data: data!)
				print("HAPPYSINGHKA \(json)")
				
//				let message = json["response"]["message"].string!
				
//				if message == "Incorrect login details"{
//					
//					
//					DispatchQueue.main.async {
//						self.performSegue(withIdentifier: "userdetailsvc", sender:nil)
//						
//					}
//					
//				}else{
					//print("proceed with the data to segue")
					let tokenV = json["response"]["data"]["session"]["token"].string!
					let sessionIdV = json["response"]["data"]["session"]["sessionid"].string!
					print("\(tokenV) \(sessionIdV)")
					
					// MARK:- user defaults for sessionid and token
					userDefaults.set(sessionIdV, forKey: "SessionIdForSaving")
					userDefaults.set(tokenV, forKey: "tokenIdForSaving")
					SESSION_ID = sessionIdV
					TOKEN_ID_FROM_LEUK = tokenV
					
					
					DispatchQueue.main.async {
						
						SESSION_ID = sessionIdV
						TOKEN_ID_FROM_LEUK = tokenV
						
						self.performSegue(withIdentifier: "sidesedoosra", sender: nil)
						
					
					
					
					
					
					
					
				}
				
				
				
			}
			
			
			
		}
		
		
		
		task2.resume()

		
		
		
		
		
		
	}
	
	
	
	
	
	
	
	
	
	 //MARK:- Picker delegates
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
 
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDataSource.count
	}
 
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerDataSource[row]
	}
	
	
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		if(row == 0)
		{
			locationVal = pickerDataSource[row]
			
		}
		else if(row == 1)
		{
			print(pickerDataSource[row])
			locationVal =  pickerDataSource[row]

		}
		else if(row == 2)
		{
			print(pickerDataSource[row])
			locationVal = pickerDataSource[row]
		}
		else
		{
			print(pickerDataSource[row])
			locationVal = pickerDataSource[row]
		}
	}
	
	
	
	// MARK:- BEMCheckBox
	
	
	
	func didTap(_ checkBox: BEMCheckBox) {
		
		if checkBox.tag == 1{
			
			self.male.on = true
			self.female.on = false
			gender = 1
		}
		if checkBox.tag == 2{
			
			self.male.on = false
			self.female.on = true
			gender = 2
		}
	}

	//MARK:- Textview delegates
	
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		
		let clicked = textField.tag
		
		if clicked == 1{
			
			let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
			let compSepByCharInSet = string.components(separatedBy: aSet)
			let numberFiltered = compSepByCharInSet.joined(separator: "")
			let newText = (phoneNumber.text! as NSString).replacingCharacters(in: range, with: numberFiltered)
			let numberOfChars = newText.characters.count // for Swift use count(newText)
			if (string == "\n") {
				textField.resignFirstResponder()
				return false
			}
			return ((string == numberFiltered ) && (numberOfChars < 11))
		}
		if clicked == 2{
			if (string == "\n") {
				textField.resignFirstResponder()
				return false
			}
		}
		return true
	}
	
	
	
	
	
}
























