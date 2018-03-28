//
//  HighSchoolService.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class HighSchoolService: NSObject {
    
    static func getHighSchools(_ completed: @escaping (ServiceResponse) -> ()){
        
        let url:String = URLConstants.getHighSchoolsUrl
    
        
        var request = URLRequest(url: URL(string:url)!)
        request.httpMethod = "GET"
        
        let serviceResponse = ServiceResponse()
        
        // Add proper headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        session.dataTask(with: request){data, response, err in
            let res = response as? HTTPURLResponse
            serviceResponse.httpStatus = res?.statusCode
            if(err != nil){
                serviceResponse.data = err?.localizedDescription
                
            } else {
                let highschools = try? JSONDecoder().decode([HighSchool].self, from: data!)
                serviceResponse.data = highschools
            }
            
            completed(serviceResponse)
            
        }.resume()
        
    }

}
