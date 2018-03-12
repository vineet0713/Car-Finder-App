//
//  CarQueryConvenience.swift
//  Car Finder
//
//  Created by Vineet Joshi on 3/10/18.
//  Copyright © 2018 Vineet Joshi. All rights reserved.
//

import Foundation

extension CarQueryClient {
    
    func getAllMakes(completionHandler: @escaping (_ success: Bool, _ errorDescription: String?)->Void) {
        let methodParameters: [String:Any] = [CarQueryParameterKeys.Method: CarQueryParameterValues.GetMakesMethod]
        let request = URLRequest(url: carqueryURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (statusCode >= 200 && statusCode <= 299) else {
                completionHandler(false, "Your request returned a status code other than 2xx.")
                return
            }
            
            guard let data = data else {
                completionHandler(false, "No data was returned.")
                return
            }
            
            var parsedResult: [String:Any]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            } catch {
                completionHandler(false, "Could not parse the data as JSON.")
                return
            }
            
            guard let makeArray = parsedResult[CarQueryResponseKeys.Makes] as? [[String:Any]] else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.Makes).")
                return
            }
            
            for make in makeArray {
                guard let makeCountry = make[CarQueryResponseKeys.MakeCountry] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.MakeCountry).")
                    return
                }
                
                guard let makeDisplay = make[CarQueryResponseKeys.MakeDisplay] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.MakeDisplay).")
                    return
                }
                
                guard let makeID = make[CarQueryResponseKeys.MakeID] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.MakeID).")
                    return
                }
                
                guard let makeCommonality = make[CarQueryResponseKeys.MakeCommonality] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.MakeCommonality).")
                    return
                }
                let makeIsCommon = (makeCommonality == CarQueryResponseValues.MakeIsCommon)
                
                SharedData.sharedInstance().makes.append(Make(country: makeCountry, name: makeDisplay, ID: makeID, isCommon: makeIsCommon))
            }
            
            completionHandler(true, nil)
        }
        
        task.resume()
    }
    
    func getModelsFor(makeID: String, completionHandler: @escaping (_ success: Bool, _ errorDescription: String?)->Void) {
        let methodParameters: [String:Any] = [CarQueryParameterKeys.Method: CarQueryParameterValues.GetModelsMethod,
                                              CarQueryParameterKeys.Make: makeID]
        let request = URLRequest(url: carqueryURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (statusCode >= 200 && statusCode <= 299) else {
                completionHandler(false, "Your request returned a status code other than 2xx.")
                return
            }
            
            guard let data = data else {
                completionHandler(false, "No data was returned.")
                return
            }
            
            var parsedResult: [String:Any]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            } catch {
                completionHandler(false, "Could not parse the data as JSON.")
                return
            }
            
            guard let modelArray = parsedResult[CarQueryResponseKeys.Models] as? [[String:Any]] else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.Models).")
                return
            }
            
            for model in modelArray {
                guard let modelName = model[CarQueryResponseKeys.ModelName] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelName).")
                    return
                }
                
                SharedData.sharedInstance().models.append(modelName)
            }
            
            completionHandler(true, nil)
        }
        
        task.resume()
    }
    
    func getTrimsFor(makeID: String, modelName: String, completionHandler: @escaping (_ success: Bool, _ errorDescription: String?)->Void) {
        let methodParameters: [String:Any] = [CarQueryParameterKeys.Method: CarQueryParameterValues.GetTrimsMethod,
                                              CarQueryParameterKeys.Make: makeID,
                                              CarQueryParameterKeys.Model: modelName,
                                              CarQueryParameterKeys.FullResults: CarQueryParameterValues.BasicResults]
        let request = URLRequest(url: carqueryURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (statusCode >= 200 && statusCode <= 299) else {
                completionHandler(false, "Your request returned a status code other than 2xx.")
                return
            }
            
            guard let data = data else {
                completionHandler(false, "No data was returned.")
                return
            }
            
            var parsedResult: [String:Any]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            } catch {
                completionHandler(false, "Could not parse the data as JSON.")
                return
            }
            
            guard let trimArray = parsedResult[CarQueryResponseKeys.Trims] as? [[String:Any]] else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.Trims).")
                return
            }
            
            for trim in trimArray {
                guard let modelID = trim[CarQueryResponseKeys.ModelID] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelID).")
                    return
                }
                
                guard let modelYear = trim[CarQueryResponseKeys.ModelYear] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelYear).")
                    return
                }
                let updatedModelYear = (modelYear == "") ? "[year unavailable]" : modelYear
                
                guard let modelTrim = trim[CarQueryResponseKeys.ModelTrim] as? String else {
                    completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelTrim).")
                    return
                }
                let updatedModelTrim = (modelTrim == "") ? "[trim unavailable]" : modelTrim
                
                SharedData.sharedInstance().trims.append(Trim(modelID: modelID, modelYear: updatedModelYear, modelTrim: updatedModelTrim))
            }
            
            completionHandler(true, nil)
        }
        
        task.resume()
    }
    
    func getModelFor(modelID: String, vehicleToSave: String, completionHandler: @escaping (_ success: Bool, _ errorDescription: String?)->Void) {
        let methodParameters: [String:Any] = [CarQueryParameterKeys.Method: CarQueryParameterValues.GetModelMethod,
                                              CarQueryParameterKeys.Model: modelID]
        let request = URLRequest(url: carqueryURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completionHandler(false, error!.localizedDescription)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (statusCode >= 200 && statusCode <= 299) else {
                completionHandler(false, "Your request returned a status code other than 2xx.")
                return
            }
            
            guard let data = data else {
                completionHandler(false, "No data was returned.")
                return
            }
            
            var parsedResult: [[String:Any]]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            } catch {
                completionHandler(false, "Could not parse the data as JSON.")
                return
            }
            
            // "flatten" the array of dictionaries into one dictionary!
            let tupleArray: [(String, Any)] = parsedResult.flatMap { $0 }
            let statisticDictionary = Dictionary(tupleArray, uniquingKeysWith: { (first, last) in last })
            
            // gets the statistics for this Vehicle
            
            var resultStatistics: [String] = []
            
            let resultKeys = CarQueryResponseKeys.statisticKeys
            for key in resultKeys {
                // if the statistic exists and is not null
                if let statistic = statisticDictionary[key] as? String {
                    // if the key is either MaxPower or MaxTorque
                    if key == CarQueryResponseKeys.MaxPower || key == CarQueryResponseKeys.MaxTorque {
                        resultStatistics.append(statistic + " RPM")
                    } else {
                        resultStatistics.append(statistic)
                    }
                } else {
                    resultStatistics.append("[unavailable]")
                }
            }
            
            // gets the basic information for this Vehicle (to potentially use if user stores this Vehicle as favorite)
            
            guard let modelYear = statisticDictionary[CarQueryResponseKeys.ModelYear] as? String else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelYear).")
                return
            }
            
            guard let makeName = statisticDictionary[CarQueryResponseKeys.MakeDisplay] as? String else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.MakeDisplay).")
                return
            }
            
            guard let modelName = statisticDictionary[CarQueryResponseKeys.ModelName] as? String else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelName).")
                return
            }
            
            let modelTitle = modelYear + " " + makeName + " " + modelName
            
            guard let modelTrim = statisticDictionary[CarQueryResponseKeys.ModelTrim] as? String else {
                completionHandler(false, "Could not find the key \(CarQueryResponseKeys.ModelTrim).")
                return
            }
            
            switch vehicleToSave {
            case "display":
                SharedData.sharedInstance().displayVehicle = Vehicle(statistics: resultStatistics, title: modelTitle, trim: modelTrim)
            case "firstComparison":
                SharedData.sharedInstance().firstComparisonVehicle = Vehicle(statistics: resultStatistics, title: modelTitle, trim: modelTrim)
            case "secondComparison":
                SharedData.sharedInstance().secondComparisonVehicle = Vehicle(statistics: resultStatistics, title: modelTitle, trim: modelTrim)
            default:
                // this should never be executed
                SharedData.sharedInstance().displayVehicle = Vehicle(statistics: resultStatistics, title: modelTitle, trim: modelTrim)
            }
            
            completionHandler(true, nil)
        }
        
        task.resume()
    }
    
}
