//
//  CarQueryConstants.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/10/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import Foundation

extension CarQueryClient {
    
    // MARK: - Constants
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "carqueryapi.com"
        static let APIPath = "/api/0.3"
    }
    
    // MARK: - Parameter Keys
    struct CarQueryParameterKeys {
        static let Method = "cmd"
        static let Make = "make"
        static let Model = "model"
        static let FullResults = "full_results"
    }
    
    // MARK: - Parameter Values
    struct CarQueryParameterValues {
        static let GetMakesMethod = "getMakes"
        static let GetModelsMethod = "getModels"
        static let GetTrimsMethod = "getTrims"
        static let GetModelMethod = "getModel"
        static let BasicResults = "0"    /* includes only basic year/make/model/trim data (improves load times!) */
        static let FullResults = "1"
    }
    
    // MARK: - Response Keys
    struct CarQueryResponseKeys {
        static let Makes = "Makes"
        static let MakeID = "make_id"
        static let MakeDisplay = "make_display"
        static let MakeCommonality = "make_is_common"
        static let MakeCountry = "make_country"
        static let Models = "Models"
        static let ModelName = "model_name"
        static let Trims = "Trims"
        static let ModelID = "model_id"
        static let ModelYear = "model_year"
        static let ModelTrim = "model_trim"
        // add JSON response keys (preferably in an array, so we can loop through them!) for the getModel method
    }
    
    // MARK: - Response Values
    struct CarQueryResponseValues {
        static let MakeIsCommon = "1"
    }
    
}
