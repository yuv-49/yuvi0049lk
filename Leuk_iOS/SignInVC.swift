//
//  SignInVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SwiftyJSON

class SignInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
	
	
	
	
	
	

	@IBAction func googleViewTapped(_ sender: Any) {
		
		
	}
	
	
	var tokenId1: String!
	
	var name: String!
	var email: String!
	var userName: String!
	var profileImage: String!
	var password: String!
	
	
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

	
	  GIDSignIn.sharedInstance().uiDelegate = self
	 // GIDSignIn.sharedInstance().signInSilently()
	  GIDSignIn.sharedInstance().delegate = self
	   password = "password"
	
	
	if GIDSignIn.sharedInstance().hasAuthInKeychain() == true{
		
		//GIDSignIn.sharedInstance().signInSilently()
		//performSegue(withIdentifier: "showloader", sender:nil)

	}
	
	
	}
	
	

	override func viewDidAppear(_ animated: Bool) {
		
		if GIDSignIn.sharedInstance().hasAuthInKeychain() {
			
			//performSegue(withIdentifier: "showloader", sender:nil)
		}
		
		//if GIDSignIn.sharedInstance().hasAuthInKeychain() {
			
			
			
			
//			let storyboard = UIStoryboard(name: "Main", bundle: nil)
//			let controller = storyboard.instantiateViewController(withIdentifier: "googledone")
//			self.present(controller, animated: true, completion: nil)
//			
		//}
			
		
	}

 
	
	
	// MARK: - Google delegates
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if(error != nil){
			print("Signin error: \(error)")
		}else {
			print("the user signed in as \(user)")
			print(user.profile.email)
			print(user.profile.name)
			print("yuvi0049 \(user.userID)")
			print("HELLOUS \(user.profile.imageURL(withDimension: 400))")
			print(user.profile.imageURL(withDimension: 400))
			
			profileImage = user.profile.imageURL(withDimension: 400).absoluteString
			print("HELLOUS" + profileImage)
			
			
			name = user.profile.name
			email = user.profile.email
			userName = user.profile.givenName
			
			
			
			let authentication = user.authentication
			tokenId1 =  authentication?.idToken
			print("YSHS: token \(tokenId)")
			
			
			if GIDSignIn.sharedInstance().hasAuthInKeychain() {
				
			}
			
			
			
			//completeSignIn(user.userID)
			
			
			
			
			
			

			apiCallForLogin()

			
			
		}
	}

	//MARK:- keychain
	
	func completeSignIn(_ id: String){
		_ = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: KEY_UID_FOR_KEYCHAIN_FROM_GOOGLE)
		print("YS: data saved to keychain")
		apiCallForLogin()
		
	}
	
	
	
	
	
	
	func apiCallForLogin(){
		
		
		//MARK:- LOGIN
		
		var login = URLRequest(url: URL(string: "\(LEUK_URL)\(PHP_INDEX)method=login")!)
		login.httpMethod = "POST"
		let postStringForNews="key=\(UNIVERSAL_KEY)&secret=\(SECRET)&email=\(email!)&username=\(email!)&password=\(email!)"
		print("\(postStringForNews)")
		
		
		login.httpBody = postStringForNews.data(using: .utf8)
		
		let task2 = URLSession.shared.dataTask(with: login) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				print("statusCode should be 200, but is \(httpStatus.statusCode)")
			}
				
			else {
				
				
				var json = JSON(data: data!)
				print("HAPPYSINGHKA \(json)")
				
				let message = json["response"]["message"].string!
					
				if message == "Incorrect login details"{
					
					
					DispatchQueue.main.async {
						self.performSegue(withIdentifier: "userdetailsvc", sender:nil)

					}
					
				}else{
					//print("proceed with the data to segue")
					let tokenV = json["response"]["data"]["session"]["token"].string!
					let sessionIdV = json["response"]["data"]["session"]["sessionid"].string!
					print("\(token) \(sessionIdV)")
					
					// MARK:- user defaults for sessionid and token
					userDefaults.set(sessionIdV, forKey: "SessionIdForSaving")
					userDefaults.set(tokenV, forKey: "tokenIdForSaving")
					SESSION_ID = sessionIdV
					TOKEN_ID_FROM_LEUK = tokenV
					

					DispatchQueue.main.async {
						
						SESSION_ID = sessionIdV
						TOKEN_ID_FROM_LEUK = tokenV
						
						self.performSegue(withIdentifier: "sidese", sender: nil)

					}
					
					
					
					
					
					
				}
				
				

			}
			
			
			
		}
		
		
		
		task2.resume()
		
		
		
	}
	
	
	
	
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	if (segue.identifier == "userdetailsvc") {
		
		let dataSegue = segue.destination as! UserDetailsVC
		dataSegue.name = name
		dataSegue.email = email
		dataSegue.userName = userName
		dataSegue.profileImageValue = profileImage
		dataSegue.token = tokenId1
		
		
	}

	
	
	
	
	
	
	
	
	
	
    }
	

}
