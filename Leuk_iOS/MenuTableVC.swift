//
//  MenuTableVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
//import FirebaseAuth
//import FBSDKLoginKit
//import SwiftKeychainWrapper

class MenuTableVC: UITableViewController {
	
	let menuOptions = ["PROFILE","MESSAGES","NOTIFICATIONS","BOOKMARKS","DISCOVER","CREDITS","REPORT A BUG","LOG OUT"]
	let menuImages = ["profile","messages","notifications","bookmarks","mycoupons","credits","discover","bug","logout"]
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.backgroundColor = UIColor(red: 255 / 255, green: 77 / 255, blue: 78 / 255, alpha: 1.0)
		view.backgroundColor = UIColor.clear
		view.backgroundColor = UIColor.leukRed()
		tableView.separatorColor = UIColor.clear
		
	}
	
	
	
//	func revealControllerToggle(){
//		
//		if revealViewController() != nil {
//			self.target = revealViewController()
//			self.action = #selector(SWRevealViewController.canResignFirstResponder)
//			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//		}
//		
//	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.tableView.reloadData()
		self.animateTable()
		
	}
	
	
	//MARK: animate the tableview cells
	func animateTable() {
		
		let cells = tableView.visibleCells
		
		//        let tableHeight: CGFloat = tableView.bounds.size.height
		
		for cell in cells {
			let cell: UITableViewCell = cell as UITableViewCell
			cell.transform = CGAffineTransform(translationX: 0, y: -20)
			cell.alpha = 0
		}
		
		var index = 0
		
		for cell in cells {
			let cell: UITableViewCell = cell as UITableViewCell
			UIView.animate(withDuration: 0.3, delay: 0.1 * Double(index), usingSpringWithDamping: 2, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
				cell.transform = CGAffineTransform(translationX: 0, y: 0)
				cell.alpha = 1
				
			}, completion: nil)
			
			index += 1
		}
		
	}
	
	
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return menuOptions.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableVCell
		
		// Configure the cell...
		
		//cell.menuImage.image = UIImage(named: menuI)
		cell.menuImage.image = UIImage(named: menuImages[(indexPath as NSIndexPath).row])
		cell.menuLabel.text = menuOptions[(indexPath as NSIndexPath).row]
		
		cell.menuLabel.textColor = UIColor.white
		
		cell.backgroundColor = UIColor.red
		cell.backgroundColor = cell.contentView.backgroundColor
		
		
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch (indexPath as NSIndexPath).row {
			
		case 0:
			print("profile")
			self.performSegue(withIdentifier: "profilesegue", sender: self)

			
			
			
			
			
		case 1:
			print("messages")
			
			
			self.revealViewController().revealToggle(animated: true)

			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				  (result : UIAlertAction) -> Void in
				    print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)



			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()
			
		case 2:
			print("notifications")
			self.revealViewController().revealToggle(animated: true)
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				//print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()
			
		case 3:
			print("bookmarks")
			self.revealViewController().revealToggle(animated: true)
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()
			
		case 4:
			print("discover")
			self.revealViewController().revealToggle(animated: true)
			//MARK:- todo
			//self.performSegue(withIdentifier: "discovernotify", sender: self)
			
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()
			
			
			
			
			
			
			//self.revealViewController().revealToggle(animated: true)
			
			//		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
			//		let offerPageVC: OfferPageViewController!
			
			//		offerPageVC = mainStoryboard.instantiateViewController(withIdentifier: "OfferPageViewController") as? OfferPageViewController
			
			//		self.present(offerPageVC, animated: true, completion: nil)
			
			
		case 5:
			print("credits")
			self.revealViewController().revealToggle(animated: true)
			
			
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()
			
		case 6:
			print("report")
			
			self.revealViewController().revealToggle(animated: true)
			
			
			let alertController = UIAlertController(title: "Coming Soon", message: "Work Under Progress", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
			
			let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
				(result : UIAlertAction) -> Void in
				print("OK")
			}
			alertController.addAction(okAction)
			self.present(alertController, animated: true, completion: nil)

			
			
			//UIAlertView.init(title: "Coming Soon", message: "Work Under Progress", delegate: self, cancelButtonTitle: "OK").show()

		case 7:
			print("logout")
			
			
			//Sign out
			GIDSignIn.sharedInstance().signOut()

			self.dismiss(animated: true, completion: nil)
			
			
			
			
			let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "signinvc") as? SignInVC
			let appDelegate  = UIApplication.shared.delegate as! AppDelegate
			appDelegate.window?.rootViewController = loginPage
			
			
			
			
			
			
			
//			if Login_value == 1{
//				//Facebook Logout
//				let loginManager = FBSDKLoginManager()
//				loginManager.logOut() // this is an instance function
//				Login_value = 0
//				print("facebook tereminated")
//				
//			} else if Login_value == 2 {
//				//Google Logout
//				GIDSignIn.sharedInstance().signOut()
//				Login_value = 0
//				print("googel terminated")
//			}
//			self.dismiss(animated: true, completion: nil)
//			
//			
//			try! FIRAuth.auth()!.signOut()
//			
//			let removeSuccessful: Bool = KeychainWrapper.defaultKeychainWrapper.removeObject(forKey: KEY_UID)
//			
//			
//			// show logout page
//			let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "SignupBoth") as? SignupVC
//			let appDelegate  = UIApplication.shared.delegate as! AppDelegate
//			//        let viewController = appDelegate.window!.rootViewController as! ViewController
//			
//			appDelegate.window?.rootViewController = loginPage
			
			
		default:
			print("none")
		}
		
	}
	
	
	
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "profilesegue") {
			let profileVC = segue.destination as! ProfileVC
			profileVC.indexValue = 2
			
			
		}
		if (segue.identifier == "discovernotify") {
			let discoverTVC = segue.destination as! DiscoverTVC
			discoverTVC.indexValue = 2
			
			
		}
	

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
