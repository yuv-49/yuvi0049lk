//
//  InsiderConstants.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 29/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import Foundation

class shopMenuItem {
	
	var itemId: String!
	var itemPlaceId: String!
	var itemImage: UIImage!
	var itemImageLink: String!
	var itemspicy: String!
	var itemName: String!
	var itemDescription: String!
	var itemLove: String!
	var itemtags: String!
	var itemRegularCost: String!
	var itemOfferCost: String!
	var itemCategory: String!
	var itemVeg: String!
	var itemNonVeg: String!
	var itemLimit: String!
	
	
	var rows : Int!

	
	var itemImageUrl: URL!
	

}
// Shop arrays

var foodForShop = [shopMenuItem]()
var groceriesForShop = [shopMenuItem]()
var medicineForShop = [shopMenuItem]()
var stationaryForShop = [shopMenuItem]()
var commonForShop = [shopMenuItem]()
var commonInCategory = [shopMenuItem]()
var commonForShopAtLast = [shopMenuItem]()


class shopCategory {
	var count: Int!
	//var
}
var categoryOfItem = [String]()


var idValues = [[String]]()
var shopValuesByCategory = [Int : [shopMenuItem]]()



var itemQuantityInNumber: Int!
var cartValues = [shopMenuItem]()
//var cartValue = [shopMenuItem]()












