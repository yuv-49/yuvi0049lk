//
//  HeavyConstants.swift
//  Leuk_iOS
//
//  Created by yuvraj singh on 22/05/17.
//  Copyright © 2017 yuvi0049. All rights reserved.
//

import Foundation





var placeServiceStatusForPayment: Int!



class profileSignupMethod{
	
	
	var name: String!
	var profileImage: String!
	var userName: String!
	var email: String!
	var gender: String!
	var phone: String!
	var password: String!
	var locaion: String!
	var dob: String!
	var referralCode: String!

	
}

var profileDetailArray = profileSignupMethod()



//MARK:- API call defaults Value


var LEUK_URL = "https://leuk.xyz/leukapi12345/"
var PHP_INDEX = "index_v22.php?"



var UNIVERSAL_KEY = "leuk12"
var SECRET = "gammayz"
var SESSION_ID : String! //= "2bdc9173b3568b4b6cdc0cd07964c4d3"
var TOKEN_ID_FROM_LEUK : String!//= "0fd3486ab4adc005ae3b915a978e231151ae927f0f7084a0f96946287726196d"

var KEY_UID_FOR_KEYCHAIN_FROM_GOOGLE = "uidFromGoogle"

