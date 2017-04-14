//
//  HomeThirdVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/03/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class HomeThirdVC: UIViewController {
	
	
	// this will be for ask leuk protocol
	
	
	@IBOutlet weak var lbl: UILabel!
	var indexValue: Int!
	
	var firstView = ["Order Now","Offers","Events","Places","Ask Leuk","Discover","Contests","Subscriptions","Profile"]


    override func viewDidLoad() {
        super.viewDidLoad()
	 lbl.text =  "\(indexValue)"
	 setNavTitle()
	 
        // Do any additional setup after loading the view.
    }

	
	func setNavTitle(){
		var i = 0
		for val in firstView {
			
			if(indexValue == i){
				self.title = val
				
				
			}
			i = i + 1
			
		}
		
		
		
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
