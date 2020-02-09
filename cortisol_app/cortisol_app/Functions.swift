//
//  Functions.swift
//  cortisol_app
//
//  Created by jamie jenkins on 2/9/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

func translateToTime(viewType: Int) -> String {
    let now = Date()
    var dateComponent = DateComponents()
    switch viewType {
    case 1:
        print("Here")
        dateComponent.days = -1
        //translate to day
        // Date "2/9/2020 00:00"
    case 2:
        print("Here")
        dateComponent.days = -7
        //translate to week
        // Date "2/2/2020 20:24"
    case 3:
        print("Here")
        dateComponent.months = -1
        //month
    default:
        print("Here")
        //dateComponent.days = -1
    }
    let newDate = Calendar.current.date(byAdding: dateComponent, to: now)
    //TEMP
    let df = DateFormatter()
    return df.string(from: now)
}

func calculateCortScore(cort: Double, max: Double, min: Double) -> Int {
    if cort > max || cort < min {
        //recalculate max and min??
        //max = ...
        //min = ...
    }
    return Int(((max - cort)/(max - min)) * 10)
}

func getGraphPoints(user_id: Int, view_type: Int) -> [Point] {
    //TEMP
    let point = Point(date: "7/7/2020", cort_level: 2.2)
    var points = [Point]()
    
    
    return points
}

func getStressDate(user_id: Int, stress: Int, view_type: Int) -> String {
        var option = "max"
        var option2 = "desc"
        if stress == 1 {
            option = "min"
            option2 = "asc"
        }
        let today = Date()
        var date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: today)!

    var db:DBHelper = DBHelper()
    db.getStressDate(user_id: user_id, stress: stress, view_type: view_type, date: date)
        
        return date_recorded
}
