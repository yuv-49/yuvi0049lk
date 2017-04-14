//
//  Constants.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import Foundation


var token: String!
var tokenId : String!
var sessionId: String!


var Name: String!
var area: String!
var referalCode: String!
var level: String!
var profileImages: String!
var totalCredits: String!
var remainingCredits: String!


class homeOffers{
	var left : String!
	var discountPercentage : String!
	var title : String!
	var image : String!
	var type: String!
	
}


var homeOffersBars = [homeOffers]()
var homeOffersF_B = [homeOffers]()
var homeOfferesApparels = [homeOffers]()
var homeOffersHappy = [homeOffers]()
var homeOffersSports = [homeOffers]()



class Places {
	
	var placeId: String!
	var placeImage: UIImage!
	var placeName: String!
	var placeType: String!
	var placeDistance: String!
	var placeRating: String!
	var placeLat: Double!
	var placeLong: Double!
	var placeAddress: String!
	var placeDescription: String!
	var phoneNumber: String!
	var mapURL: String!
	
	var image1: UIImage!
}


var restaurantValues = [Places]()
var storesValues = [Places]()
var pubsValues = [Places]()
var EntertainmentValues = [Places]()
var cafeValues = [Places]()
var MedicalValues = [Places]()








