//
//  ApiClient.swift
//  OkCupidProject
//
//  Created by David Nadri on 10/20/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//
// Improvement: Use an API client on the model object 

import Alamofire
import SwiftyJSON

typealias MatchCallback = (Match) -> Match
typealias ErrorCallback = (NSError) -> Void

protocol MatchApiClient {
    static func requestMatches(onSuccess: MatchCallback?,
                               onError: ErrorCallback?)
}

class ApiClient: MatchApiClient {
    
    static func requestMatches(onSuccess: MatchCallback? = nil,
                                onError: ErrorCallback? = nil) {
        let endpoint = "https://www.okcupid.com/matchSample.json"
        
        Alamofire.request(.GET, endpoint)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    
                    if let matchData = response.result.value {
                        //let json = JSON(matchData)
                        //print("json \(json)")
                        
                        for match in matchData as! [AnyObject] {
                            guard let photoURL = match["photo"]!!["full_paths"]!!["original"] as? String else {
                                return
                            }
                            
                            guard let username = match["username"] as? String else {
                                return
                            }
                            
                            guard let age = match["age"] as? Int else {
                                return
                            }
                            
                            guard let cityName = match["location"]!!["city_name"] as? String else {
                                return
                            }
                            
                            guard let stateCode = match["location"]!!["state_code"] as? String else {
                                return
                            }
                            
                            guard let matchPercent = match["match"] as? Int else {
                                return
                            }
                            
                            guard let isOnline = match["is_online"] as? Int else {
                                return
                            }
                            
                            onSuccess?(Match(photoURL: photoURL, username: username, age: age, cityName: cityName, stateCode: stateCode, matchPercent: matchPercent, isOnline: isOnline))
                            
                        }
                        
                    }
                    
                case .Failure(let error):
                    onError?(error)
                    
                    // ERROR
                    print("ERROR: \(response.result.error!)")
                    let alert = UIAlertController(title: "Error", message: "Whoops! Looks like an error occurred. Please try again later. (Code: \(response.result.error?.code))", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                    alert.presentViewController(alert, animated: true, completion: nil)
                    
                    return
                }
        }
        
    }
    
}
