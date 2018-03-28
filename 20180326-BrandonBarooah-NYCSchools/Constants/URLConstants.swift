//
//  URLConstants.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class URLConstants: NSObject {

    static var dev = "https://data.cityofnewyork.us"
    static var stage = ""
    static var prod =  ""
    
    // Set environment here
    static var baseUrl = dev
    static var getHighSchoolsUrl = baseUrl + "/resource/97mf-9njv.json"
    static var getSATScoresUrl = baseUrl + "/resource/734v-jeq5.json"
}
