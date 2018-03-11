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
        static let Class = "model_body"
        static let Seats = "model_seats"
        static let EnginePosition = "model_engine_position"
        static let Displacement = "model_engine_l"
        static let EngineType = "model_engine_type"
        static let Cylinders = "model_engine_cyl"
        static let CompressionRatio = "model_engine_compression"
        static let ValvesPerCylinder = "model_engine_valves_per_cyl"
        static let Horsepower = "model_engine_power_hp"
        static let MaxPower = "model_engine_power_rpm"
        static let Torque = "model_engine_torque_lbft"
        static let MaxTorque = "model_engine_torque_rpm"
        static let TopSpeed = "model_top_speed_mph"
        static let Drive = "model_drive"
        static let Transmission = "model_transmission_type"
        static let Fuel = "model_engine_fuel"
        static let Capacity = "model_fuel_cap_g"
        static let MPGCity = "model_mpg_city"
        static let MPGHighway = "model_mpg_highway"
        static let MPGCombined = "model_mpg_mixed"
        static let Weight = "model_weight_lbs"
        static let Length = "model_length_in"
        static let Width = "model_width_in"
        static let Height = "model_height_in"
        static let Wheelbase = "model_wheelbase_in"
        static let statisticKeys = [Class, Seats, EnginePosition, Displacement, EngineType, Cylinders, CompressionRatio, ValvesPerCylinder, Horsepower, MaxPower, Torque, MaxTorque, TopSpeed, Drive, Transmission, Fuel, Capacity, MPGCity, MPGHighway, MPGCombined, Weight, Length, Width, Height, Wheelbase]
    }
    
    // MARK: - Response Values
    struct CarQueryResponseValues {
        static let MakeIsCommon = "1"
    }
    
}
