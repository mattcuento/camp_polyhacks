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
    private var id: Int64
    
    //Default Constructor
    init(isPositive: Bool, name: String, id: Int64){
        self.isPositive = isPositive
        self.name = name
        self.id = id
    }
    
    // Getter Functions
    func getIsPositive() -> Bool{
        return self.isPositive
    }
    func getName() -> String{
        return self.name;
    }
    func getId() -> Int64{
        return self.id
    }
    
    // Setter Fubnctions
    func setIsPositive(isPositive: Bool){
        self.isPositive = isPositive
    }
    
    func setId(id: Int64){
        self.id = id
    }
    
}

extension Activity: Equatable{
    static func == (lhs: Activity, rhs: Activity) -> Bool{
        return (lhs.getIsPositive == rhs.getIsPositive) && (lhs.getName == rhs.getName) && (lhs.getId == rhs.getId)
    }
}
