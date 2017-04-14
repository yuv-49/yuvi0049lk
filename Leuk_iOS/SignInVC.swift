//
//  SignInVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

	@IBAction func googleViewTapped(_ sender: Any) {
		
		
	}
	
	
	var tokenId: String!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

	
	  GIDSignIn.sharedInstance().uiDelegate = self
	 // GIDSignIn.sharedInstance().signInSilently()
	  GIDSignIn.sharedInstance().delegate = self
	
	
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	
	// MARK: - Google delegates
	
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if(error != nil){
			print("Signin error: \(error)")
		}else {
			print("the user signed in as \(user)")
			print(user.profile.email)
			print(user.profile.name)
			print(user.userID)
			print(user.profile.imageURL(withDimension: 400))
			//print()
			
			let authentication = user.authentication
			tokenId =  authentication?.idToken
			print("YSHS: token \(tokenId)")
			
			
			if GIDSignIn.sharedInstance().hasAuthInKeychain() {
				
				performSegue(withIdentifier: "showloader", sender:nil)
			}
			
			
			
			//performSegue(withIdentifier: "showloader", sender:nil)

			
			
		}
	}

	
	
	
	
	
	

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	
	if (segue.identifier == "showloader") {
		
		let loadingDataVC = segue.destination as! LoadingDataVC
		loadingDataVC.tokenIdFromGoogle = tokenId
		
	}

	
	
	
	
	
	
	
	
	
	
    }
    

}
