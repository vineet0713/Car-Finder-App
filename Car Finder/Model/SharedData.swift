//
//  SharedData.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/10/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import Foundation

class SharedData {
    
    // MARK: Properties
    
    var makes: [Make] = []
    var models: [String] = []   // since a 'Model' has just one attribute (modelName)!
    var trims: [Trim] = []
    
    // MARK: Initializers
    
    private init() {}
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> SharedData {
        struct Singleton {
            static var sharedInstance = SharedData()
        }
        return Singleton.sharedInstance
    }
    
}
