//
//  Point.swift
//  cortisol_app
//
//  Created by Shah Samiur Rahman on 2/9/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

class Point{
    private let date: String
    private let cortLevel: Double
    
    // Constructor
    init(date: String, cortLevel: Double){
        self.date = date
        self.cortLevel = cortLevel
    }
    
    // Getter Fucntions
    func getDate() -> String{
        return self.date
    }
    func getCortLevel() -> Double{
        return self.cortLevel
    }
    
}

extension Point: Equatable{
    static func ==(lhs: Point, rhs: Point) -> Bool{
        return (lhs.getDate() == rhs.getDate()) && (lhs.getCortLevel() == rhs.getCortLevel())
    }
}
