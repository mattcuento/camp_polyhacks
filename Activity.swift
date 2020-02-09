//
//  Activity.swift
//  cortisol_app
//
//  Created by Shah Samiur Rahman on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

class Activity{
    private var is_positive: Int // Indicates whether Activity is positive or negative.
    private var activity_name: String
    private var id: Int
    private var user_id: Int
    
    //Default Constructor
    init(is_positive: Int, name: String, id: Int, user_id: Int){
        self.is_positive = is_positive
        self.activity_name = name
        self.id = id
        self.user_id = user_id
    }
    
    // Getter Functions
    func getIsPositive() -> Int{
        return self.is_positive
    }
    func getActivityName() -> String{
        return self.activity_name;
    }
    
    func getUserId() -> Int{
        return self.user_id;
    }
    
    // Setter Fubnctions
    func setIsPositive(isPositive: Int){
        self.is_positive = isPositive
    }
    
    func setActivityName(name: String){
        self.activity_name = name
    }
    
    func setUserId(id: Int){
        self.user_id = id
    }
}
