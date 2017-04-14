//
//  OrderVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit

class OrderVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet weak var myCollectionView: UICollectionView!
	class func instantiateFromStoryboard() -> OrderVC {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "ordervc") as! OrderVC
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ordercell", for: indexPath) as! OrderVCell
		return cell
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
