//
//  Match.swift
//  OkCupidProject
//
//  Created by David Nadri on 10/20/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import Foundation

class Match {
    
    var photoURL: String?
    var username: String?
    var age: Int?
    var cityName: String?
    var stateCode: String?
    var matchPercent: Int?
    var isOnline: Int?
    
    init(photoURL: String?, username: String?, age: Int?, cityName: String?, stateCode: String?, matchPercent: Int?, isOnline: Int?) {
        self.photoURL = photoURL
        self.username = username
        self.age = age
        self.cityName = cityName
        self.stateCode = stateCode
        self.matchPercent = matchPercent
        self.isOnline = isOnline
    }
    
}
