//
//  EarliestVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 24/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class EarliestVC: UIViewController, UIPageViewControllerDataSource  {
	
	
	var pageViewController: UIPageViewController!
	var pageTitles: NSArray!
	var pageImages: NSArray!
	
	

    override func viewDidLoad() {
        super.viewDidLoad()


	setPagingMenuThings()
	
	}
	
	func setPagingMenuThings(){
		
		self.pageImages = NSArray(objects: "page1","page2","page3")
		self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "pageViewController") as! UIPageViewController
		self.pageViewController.dataSource = self
		
		let startVC = self.viewControllerAtIndex(0) as ContentVC
		let viewControllers = NSArray(object: startVC)
		
		self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: true, completion: nil)
		self.pageViewController.view.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 30)
		self.addChildViewController(self.pageViewController)
		self.view.addSubview(self.pageViewController.view)
		self.pageViewController.didMove(toParentViewController: self)

		
	}
	
	
	func viewControllerAtIndex(_ index: Int) -> ContentVC {
		
		if self.pageImages.count == 0 ||  index >= self.pageImages.count {
			return ContentVC()
		}
		
		let vc : ContentVC = self.storyboard?.instantiateViewController(withIdentifier: "contentVC") as! ContentVC
		vc.imageFile = self.pageImages[index] as! String
		vc.pageIndex = index
		return vc
	}
	
	
	
	
	
	
	
	
	
	
	// MARK: pageViewController data Source Protocols
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		let vc = viewController as! ContentVC
		var index =  vc.pageIndex as Int
		
		if index == 0 || index == NSNotFound {
			return nil
		}
		
		index -= 1
		return self.viewControllerAtIndex(index)
	}
	
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		let vc = viewController as! ContentVC
		var index = vc.pageIndex as Int
		
		if index == NSNotFound {
			return nil
		}
		index += 1
		
		if index == self.pageImages.count {
			// here add the next page for the loginUI.
			print("last Page")
			//self.dismiss(animated: true, completion: nil)
			
			return nil
		}
		
		return self.viewControllerAtIndex(index)
	}
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return self.pageImages.count
	}
	
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return 0
	}
	
	
	

	
	
	
	
	override func viewDidAppear(_ animated: Bool) {
		//MARK:- uncomment this ,important....
//		if let _ = SESSION_ID {//  KeychainWrapper.standard.string(forKey: KEY_UID_FOR_KEYCHAIN_FROM_GOOGLE){
//			print("YS: ID found in keychain")
//			performSegue(withIdentifier: "earliest", sender: nil)
//		}
		
		if let SessionIdForSaving = userDefaults.value(forKey: "SessionIdForSaving") {
			
			if let tokenIdForSaving = userDefaults.value(forKey: "tokenIdForSaving") {
			
			
				SESSION_ID = SessionIdForSaving as? String
				TOKEN_ID_FROM_LEUK = tokenIdForSaving as? String
			
				performSegue(withIdentifier: "earliest", sender: nil)
			}
		
		}
		
		
		
		
		
		
	}

	
}
