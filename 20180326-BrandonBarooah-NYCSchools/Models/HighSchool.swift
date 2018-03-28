//
//  HighSchool.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class HighSchool: NSObject, Codable {

    var dbn: String?    // We'll use this to identify the highschool
    var name: String?
    var city: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    
    init(name:String?, city:String?, address:String?){
        self.name = name
        self.city = city
        self.address = address
    }
    
    // Used to map the json keys that dont match the model's property names
    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case city
        case address = "primary_address_line_1"
        case latitude
        case longitude
    }
    
    
}
