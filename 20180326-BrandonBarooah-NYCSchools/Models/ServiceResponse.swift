//
//  ServiceResponse.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

// Generic service response that all services should use to keep UI abstracted from individual response models
class ServiceResponse: NSObject {
    
    var httpStatus : Int!
    var data : Any?
    
    init(httpStatus : Int!, data : Any?){
        self.httpStatus = httpStatus
        self.data = data
    }
    
    convenience override init() {
        self.init(httpStatus : 200, data: nil) // 200 OK http status
    }
    
}

// Used when deserializing json to proper models
enum SerializationError: Error {
    case generic()
}
