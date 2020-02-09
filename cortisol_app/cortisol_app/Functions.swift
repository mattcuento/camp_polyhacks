//
//  Functions.swift
//  cortisol_app
//
//  Created by jamie jenkins on 2/9/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

//COMPLETE, TEST
func calculateCortScore(cort: Double, max: Double, min: Double) -> Int {
    if cort > max || cort < min {
        //recalculate max and min??
        //max = ...
        //min = ...
    }
    return Int(((max - cort)/(max - min)) * 10)
}

//SAM
func getGraphPoints(user_id: Int, view_type: Int) -> [Point] {
    //TEMP
    let point = Point(date: "7/7/2020", cortLevel: 2.2)
    let points = [Point]()
    
    
    return points
}

func getStressDate(user_id: Int, stress: Int, view_type: Int) -> String {
    let today = Date()
    let db:DBHelper = DBHelper()
    let ret = db.stressDateQuery(user_id: user_id, stress: stress, view_type: view_type, date: today)
        return ret
}
