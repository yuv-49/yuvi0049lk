//
//  ContentVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 24/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
	
	
	
	@IBOutlet weak var startBtn: UIButton!
	@IBOutlet weak var startImage: UIImageView!
	
	
	var pageIndex: Int!
	var imageFile: String!

	

    override func viewDidLoad() {
        super.viewDidLoad()

	self.startImage.image = UIImage(named: self.imageFile)
	startBtn.isHidden = (self.startImage.image == UIImage(named: "page3")) ? false : true


	}

	@IBAction func startBtnTapped(_ sender: Any) {
		
		print("perform segue  signinvc")
		performSegue(withIdentifier: "signinvc", sender: nil)

	}
	
}
