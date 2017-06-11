//
//  Constants.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 14/04/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import Foundation



var YOUR_PUBLIC_KEY =  "rzp_live_chMEONGnMsyuTW"  /* "rzp_test_Jq60z50TZrtFeL"*/ // "rzp_live_chMEONGnMsyuTW"
var YOUR_PRIVATE_KEY = ""





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

var userLatitude: Double!
var userLongitude: Double!





class HomeOffers{
	var offerBy : String!
	var offerById: String!
	var offerDiscount : String!
	var offerTitle : String!
	var offerImage : String!
	var offerDeal: String!
	var offerCategory: String!
	var offerImageOriginal: UIImage!
	var offerDesc: String!
	var offerExpiry: String!
	var offerTiming: String!
	var recommended: String!
	var views: String!
	
}



var homeOffersBars = [HomeOffers]()
var homeOffersF_B = [HomeOffers]()
var homeOfferesApparels = [HomeOffers]()
var homeOffersHappy = [HomeOffers]()
var homeOffersSports = [HomeOffers]()
var homeOffersSpa = [HomeOffers]()

var pageTwoValues = [HomeOffers]()


var offerToPlaceTransition = 0
var placeTransitionArray = Places()



class Places {
	
	var placeId: String!
	var placeImageFullLink: String!
	var placeImage: UIImage!
	var placeImageLink: String!
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
	var placeArea: String!
	var photoLink: String!
	var featured: String!
	var recommended : String!
	
	var openingTimeHour: String!
	var closingTimeHour: String!
	
	var openingTimeMinute: String!
	var closingTimeMinute: String!
	
	var statusEach: String!
	
	
	var views: String!
	
	var image1: UIImage!
	var image1Link: String!
	
	var lastUpdate: String!
	
	var placeFirstImageUrl: URL!
	var placeSecondImageUrl: URL!
	
	var service: String!
	var orderType: String!
	
	
	
	
}



// places

var restaurantValues = [Places]()
var storesValues = [Places]()
var pubsValues = [Places]()
var EntertainmentValues = [Places]()
var cafeValues = [Places]()
var MedicalValues = [Places]()

// order now

var restaurantOrder = [Places]()
var GroceriesOrder = [Places]()
var MedicineOrder = [Places]()
var staitionaryOrder = [Places]()

// Profile


var pageOneValues = [Places]()
var pageFourValues = [Places]()

var orderDetailsForUser = Places()



class homeEvents{
	var eventId : String!
	var eventLogo : String!
	var eventName : String!
	var eventImageLink : String!
	var eventHostedBy : String!
	var eventDate : String!
	var eventTime : String!
	var eventDifference: String!
	var eventCategory: String!
	var eventTicketBasecode: String!
	var eventImageOriginal: UIImage!
	var eventLogoOriginal: UIImage!
	
	
	var eventWebsite: String!
	
	var recommended : String!
	
	var eventPhoneNumber: String!
	var eventFee: String!
	var eventDesc : String!
	var eventAddress: String!
	
	var views: String!
	var eventTicketSales: String!
	var eventTicketLimit: String!
	
	var eventSingleLimit: String!
	
	
	var eventLat: String!
	var eventLong: String!
	
	
	
	
}


var foodValues = [homeEvents]()
var socialValues = [homeEvents]()
var startupValues = [homeEvents]()
var sportsValues = [homeEvents]()
var meetupValues = [homeEvents]()
var partyValues = [homeEvents]()

var pageThreeValues = [homeEvents]()





class PopularNews{
	
	var newsId: String!
	var hits: String!
	var newsTitle: String!
	var imageLink: String!
	var pageLink: String!
	var newsLocation: String!
	var newsSource: String!
	var newsStatus: String!
	var newsType: String!
	
	var imageLinkOriginal: UIImage!

	
}

var firstPageNews = [PopularNews]()



let userDefaults = UserDefaults.standard




var countOfPagesForFirstPage: Int!



















