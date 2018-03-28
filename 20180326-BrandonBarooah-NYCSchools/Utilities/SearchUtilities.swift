//
//  SearchUtilities.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class SearchUtilities: NSObject {

    // Takes in a keyword and filters
    static func getHighSchoolSubset(_ highschools:[HighSchool],_ keyword:String) -> [HighSchool]{
        return highschools.filter{($0.name?.localizedCaseInsensitiveContains(keyword))! || ($0.address?.localizedCaseInsensitiveContains(keyword))!}
    }
}
