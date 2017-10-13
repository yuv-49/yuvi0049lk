//
//  Banners.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 07/10/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import Foundation



class Feeds
{
	
	var id: String!
	var title: String!
	var type: String!
	var tags:String!
	var parameters: String!
	var gender: String!
	var time: String!
	var day: String!
	var priority: String!
	var location: String!
	var status: String!
	
	
	
}

var homeFeed = [Feeds]()



class Banners {
	
	var id: String!
	var image: String!
	var url: String!
	var type: String!
	var kind: String!
	var keyParam: String!
	var displayDate: String!
	var location: String!
	var views: String!
	var status: String!
	
	
	
	
}


var homeBanners = [Banners]()
var nextPage = [String:Feeds]()

var currentHour: String!




