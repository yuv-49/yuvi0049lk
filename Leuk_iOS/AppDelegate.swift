//
//  AppDelegate.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		

		// Mark:- Google configuration.
		
		
		
		
		
		let textAttributes = [NSForegroundColorAttributeName:UIColor.leukRed()]
		UINavigationBar.appearance().titleTextAttributes = textAttributes
		
		var configureError: NSError?
		GGLContext.sharedInstance().configureWithError(&configureError)
		if (configureError != nil){
			print("error: \(String(describing: configureError))")
		}
		
//		if GIDSignIn.sharedInstance().hasAuthInKeychain() {
//			
//						
//			let sb = UIStoryboard(name: "Main", bundle: nil)
//			if let tabBarVC = sb.instantiateViewController(withIdentifier: "googledone") as? UIViewController {
//				window?.rootViewController = tabBarVC
//			}
//			
//		}
		
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "Leuk_iOS")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

	
		
//	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//		return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
//	}
	
	
	
	
	
	
	//MARK:- Google Signup
	
	func application(_ application: UIApplication,
	                 open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
		
		let googleDidHandle = GIDSignIn.sharedInstance().handle(url,
		                                                        sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
		                                                        annotation: options[UIApplicationOpenURLOptionsKey.annotation])
		
//		let facebookDidHandle = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
		
		
		return googleDidHandle // || facebookDidHandle
		
	}
}

	

//MARK: - colour extension

extension UIColor {
	
	static func candyGreen() -> UIColor {
		return UIColor(red: 156.0/255.0, green: 229.0/255.0, blue: 124.0/255.0, alpha: 1.0)
	}
	
	static func myGreen() -> UIColor {
		return UIColor(red: 133.0/255.0, green: 190.0/255.0, blue: 0.0/255.0, alpha: 1.0)
	}
	static func black() -> UIColor {
		return UIColor(red: 36.0/255.0, green: 36.0/255.0, blue: 36.0/255.0, alpha: 1.0)
	}
	
	static func darkRed() -> UIColor {
		return UIColor(red: 101/255.0, green: 13/255.0, blue: 0/255.0, alpha:1.0)
	}
	
	static func lightRed() -> UIColor {
		return UIColor(red: 120/255.0, green: 13/255.0, blue: 20/255.0, alpha:1.0)
	}
	
	static func leukRed() -> UIColor {
		return UIColor(red: 245/255.0, green: 83/255.0, blue: 80/255.0, alpha:1.0)
	}
	
	static func pageControlColor() -> UIColor {
		return UIColor(red: 190/255.0, green: 30/255.0, blue: 45/255.0, alpha:1.0)
	}
	
}

	
	

extension String {
	var asDate: NSDate {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.date(from: self)! as NSDate
	}
}

extension NSDate {
	func daysFrom(date:NSDate) -> Int {
		//return NSCalendar.currentCalendar.components(.CalendarUnitDay, fromDate: date, toDate: self, options: nil).day
		return Calendar.current.component(.calendar, from: date as Date)
		
	}
	
}













