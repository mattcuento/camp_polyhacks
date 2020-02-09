//
//  Activity.swift
//  cortisol_app
//
//  Created by Shah Samiur Rahman on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

class Activity{
    private var isPositive: Bool // Indicates whether Activity is positive or negative.
    private var name: String
    private var cortisolLevel: Double
    
    //Default Constructor
    init(isPositive: Bool, name: String, cortisolLevel: Double){
        self.isPositive = isPositive
        self.name = name
        self.cortisolLevel = cortisolLevel
    }
    
    // Getter Functions
    func getIsPositive() -> Bool{
        return self.isPositive
    }
    func getName() -> String{
        return self.name;
    }
    func getCortisolLevel() -> Double{
        return self.cortisolLevel
    }
    
    // Setter Fubnctions
    func setIsPositive(isPositive: Bool){
        self.isPositive = isPositive
    }
    
    func setCortisolLevel(cortisolLevel: Double){
        self.cortisolLevel = cortisolLevel
    }
    
}

