//
//  Report.swift
//  cortisol_app
//
//  Created by Shah Samiur Rahman on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

class Report{
    struct Point {
        let date: String
        let cort_level: Double
    }
    private var id: Int // SQL
    private var user_id: Int
    private var max_cort: Double
    private var min_cort: Double
    private var view_type: Int // 1 = day, 2 = week, 3 = month
    private var threeMostStress: [Activity]
    private var threeLeastStress: [Activity]
    private var stressHighDate: String?
    private var stressLowDate: String?
    private var graphPoints: [Point]?
    init(id: Int, user_id: Int, max_cort: Double, min_cort: Double, view_type: Int){
        self.id = id;
        self.user_id = user_id
        self.max_cort = max_cort
        self.min_cort = min_cort
        self.view_type = view_type
        self.stressHighDate = nil
        self.stressLowDate = nil
        //self.threeMostStress = getThreeStressActivities(self.user_id, self.view_type, 1)
        //self.threeLeastStress = getThreeStressActivities(self.user_id, self.view_type, 0)
        self.stressHighDate = getStressDate(user_id: user_id, stress: 1, view_type: view_type)
        self.stressLowDate = getStressDate(user_id: user_id, stress: 0, view_type: view_type)
        self.graphPoints = getGraphPoints(user_id: user_id, view_type: view_type)
    }
    
    func getId() -> Int {
        return self.id
    }
    
    func getUserId() -> Int {
        return self.user_id
    }
    
    func getMaxCort() -> Double {
        return self.max_cort
    }
    
    func getMinCort() -> Double {
        return self.min_cort
    }
    
    func getViewType() -> Int {
        return self.view_type
    }
    
    func getThreeStress(stress: Int) ->[Activity] {
        if stress == 1 {
            return self.threeMostStress
        } else {
            return self.threeLeastStress
        }
    }
    
    func getStressDate(stress: Int) -> String {
        let now = Date()
        let df = DateFormatter()
        let str = df.string(from: now)
        if stress == 1 {
            return self.stressHighDate ?? str
        } else {
            return self.stressLowDate ?? str
        }
    }
    
    /*func getGraphPoints() -> [[String:Int]] {
        return self.graphPoints
    }*/
    
    func setMaxCort(max: Double) {
        self.max_cort = max
        return
    }
    
    func setMinCort(min: Double) {
        self.min_cort = min
        return
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
            switch view_type {
            case 1:
                date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: today)!
                //grab max cortisol entry with todays date
                //day
            case 2:
                date = Calendar.current.date(byAdding: .day, value: -7, to: today)!
                //grab max cortisol entry with this week
                //week
            case 3:
                date = Calendar.current.date(byAdding: .month, value: -1, to: today)!
                //grab max cortisol entry with this month
                //month
            default:
                //not sure
                date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: today)!
            }
            print(date)
            let stressDateString = "select date_recorded, \(option)(cort_level) from cortisolLevels where date_recorded >= \(date) order by cort_level \(option2);"
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd hh:mm:ss"
            var date_recorded = df.string(from: Date())
            //var queryStatement: OpaquePointer? = nil
            //if sqlite3_prepare_v2(db, stressDateString, -1, &queryStatement, nil) == SQLITE_OK {
              //  if sqlite3_step(queryStatement) == SQLITE_ROW {
                    //date_recorded = String(describing: String(cString: //sqlite3_column_text(queryStatement, 0)))
             //       print("Query Result:")
             //       print("\(date_recorded)")
             //   } else {
            //        print("Date not collected.")
            //    }
            //} else {
            //    print("SELECT statement could not be prepared")
            //}
           // sqlite3_finalize(queryStatement)
            return date_recorded
    }
    
    func getGraphPoints(user_id: Int, view_type: Int) -> [Point] {
        //TEMP
        let point = Point(date: "7/7/2020", cort_level: 2.2)
        var points = [Point]()
        
        
        return points
    }
}
