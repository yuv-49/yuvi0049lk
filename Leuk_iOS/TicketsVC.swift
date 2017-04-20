//
//  EventsVC.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 13/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import UIKit


// Also known as tickets,coz u know....



class TicketsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	@IBOutlet weak var myCollectionView: UICollectionView!
	
	class func instantiateFromStoryboard() -> TicketsVC {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "eventsvc") as! TicketsVC
	}

    override func viewDidLoad() {
        super.viewDidLoad()

	
	apiCall()
	
	
	
	
	
    }

	
	func apiCall(){
		
		
		// MARK:- PROFILE MYTICKETS
		
		var myTickets = URLRequest(url: URL(string: "https://leuk.xyz/leukapi12345/index_v21.php?method=myTickets")!)
		myTickets.httpMethod = "POST"
		let postStringForTickets="key=leuk12&secret=gammayz&sessionid=2bdc9173b3568b4b6cdc0cd07964c4d3&token=0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"
		print("\(postStringForTickets)")
		
		
		myTickets.httpBody = postStringForTickets.data(using: .utf8)
		
		let taskForTickets = URLSession.shared.dataTask(with: myTickets) { data, response, error in
			if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
				//print("statusCode should be 200, but is \(httpStatus.statusCode)")
				//print("response = \(response)")
			}
				
			else {
				print("RFcss")
				let responseString = String(data: data!, encoding: .utf8)
				print("responseString = \(responseString!)")
				
			
				
	// EDIT THE VALUES INTO THE ARRAY
				
				
				

			}
		}
		
		taskForTickets.resume()

		
		
		
		
		
	}
	
	
	
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventcell", for: indexPath) as! TicketsVCell
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
