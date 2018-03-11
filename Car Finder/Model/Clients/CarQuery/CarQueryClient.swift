//
//  CarQueryClient.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/10/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import Foundation

class CarQueryClient: NSObject {
    
    // MARK: - Shared Session
    var session = URLSession.shared
    
    // MARK: - Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: - Shared Instance
    
    class func sharedInstance() -> CarQueryClient {
        struct Singleton {
            static var sharedInstance = CarQueryClient()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: - Helper Functions
    
    func carqueryURLFromParameters(_ parameters: [String:Any]) -> URL {
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
}
