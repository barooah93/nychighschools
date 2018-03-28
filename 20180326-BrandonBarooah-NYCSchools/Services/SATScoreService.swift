//
//  SATScoreService.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/27/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class SATScoreService: NSObject {

    static func getSATScores(_ dbn: String, _ completed: @escaping (ServiceResponse) -> ()){
        
        var url:String = URLConstants.getSATScoresUrl
        
        // Add dbn parameter to only receive the SAT scores of the selected school
        url += "?dbn=\(dbn)"
        
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
                let scores = try? JSONDecoder().decode([SATScores].self, from: data!)
                serviceResponse.data = scores
            }
            
            completed(serviceResponse)
            
            }.resume()
        
    }
}
