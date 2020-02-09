//
//  DBHelper.swift
//  cortisol_app
//
//  Created by Matt Cuento on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation
import SQLite3

class Users{
    init(id: Int, email: String, fname: String, lname: String){
        return
    }
}

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "cortisolApp.db"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("Error opening database.")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let cortisolLevelsTable = "create table if not exists cortisolLevels (id int primary key, user_id int, cort_level double, activity_num int, date_recorded varchar(50));"
        let activitiesTable = "create table if not exists activities (id int primary key, activity_name varchar(80), positivity int, user_id int);"
        let reportsTable = "create table if not exists reports(id int primary key, max_cort double, min_cort double, view_type int);"
        let reportMetasTable = "create table if not exists reportMetas(id int primary key, descriptor varchar(30));"
        let cortisolLevelsArchiveTable = "create table if not exists cortisolLevelsArchive (id int primary key, user_id int, cort_level double, activity_num int, date_recorded varchar(50));"
        let reportsArchiveTable = "create table if not exists reportsArchive(id int primary key, max_cort double, min_cort double, view_type int);"
        let usersTable = "create table if not exists Users(int id primary key, email varchar(80), fname varchar(50), lname varchar(80), password varchar(100));"
        let tableCreation: [String] = [cortisolLevelsTable, activitiesTable, reportsTable, reportMetasTable, cortisolLevelsArchiveTable, reportsArchiveTable, usersTable]
        for currentQuery in tableCreation {
            var createTableStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, currentQuery, -1, &createTableStatement, nil) == SQLITE_OK
            {
                if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("Table created.")
                } else {
                    print("Table not created.")
                }
            } else {
                print("CREATE TABLE statement could not be prepared.")
            }
            sqlite3_finalize(createTableStatement)
        }
    }
    
    
    func insertUsers(id:Int, email:String, fname:String, lname:String, passwd: String)
    {
        let users = readUsers()
        for usr in users
        {
            if usr.getId() == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO users (id, email, fname, lname, password) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (fname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (lname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (passwd as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 6, Int32())
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
   
    func insertActivities(id:Int, activity_name: String, positivity: Int, user_id: Int) {
           let activities = readActivities()
           for actvs in activities
           {
            if actvs.getActivityName() == activity_name
               {
                   return
               }
           }
           let insertStatementString = "INSERT INTO activities (id, activity_name, positivity) VALUES (?, ?, ?);"
           var insertStatement: OpaquePointer? = nil
           if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               sqlite3_bind_int(insertStatement, 1, Int32(id))
               sqlite3_bind_text(insertStatement, 2, (activity_name as NSString).utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 3, Int32(positivity))
                sqlite3_bind_int(insertStatement, 4, Int32(user_id))
               if sqlite3_step(insertStatement) == SQLITE_DONE {
                   print("Successfully inserted row.")
               } else {
                   print("Could not insert row.")
               }
           } else {
               print("INSERT statement could not be prepared.")
           }
           sqlite3_finalize(insertStatement)
       }
    
    func readUsers() -> [User] {
        let queryStatementString = "SELECT * FROM users;"
        var queryStatement: OpaquePointer? = nil
        //person
        var usrs : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let fname = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let lname = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                usrs.append(User(id: Int64(id), email: email, password: password, firstName: fname, lastName: lname))
                print("Query Result:")
                print("\(id) | \(password) | \(email) | \(fname) | \(lname)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return usrs
    }
    
    func readActivities() -> [Activity] {
        let queryStatementString = "SELECT * FROM activities;"
        var queryStatement: OpaquePointer? = nil
        var activities : [Activity] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let activity_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let positivity = sqlite3_column_int(queryStatement, 2)
                let user_id = sqlite3_column_int(queryStatement, 3)
                activities.append(Activity(is_positive: Int(positivity), name: activity_name, id: Int(id), user_id: Int(user_id)))
                print("Query Result:")
                print("\(id) | \(activity_name) | \(positivity) | \(user_id)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return activities
    }
    
    func getThreeActivities(viewType: Int, positivity: Int, user_id:Int) -> [Activity]{
        //TODO fix date here
        var order = "desc"
        if positivity == 0 {
            order = "asc"
        }
        let getThreeQuery = "select activity_num, activity_name, count(*) from cortisolLevels, activities where rownum < 4 and activity_num = activities.id and positivity = \(positivity) group by activity_num order by count(*) \(order);"
        var queryStatement: OpaquePointer? = nil
        var activities: [Activity] = []
        if sqlite3_prepare_v2(db, getThreeQuery, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let activity_num = sqlite3_column_int(queryStatement, 0)
                let activity_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let frequency = sqlite3_column_int(queryStatement, 2)
                activities.append(Activity(is_positive: positivity, name: activity_name, id: Int(activity_num), user_id: user_id))
                print("Query Result:")
            print("\(activity_num) | \(activity_name) | \(frequency)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return activities
    }
    
    func computeMaxMinCortLvls(viewType: Int, id: Int) -> [String:Double] {
        //TODO fix date here
        let getMaxString = "select max(cort_level) from cortisolLevels where user_id = \(id);"
        let getMinString = "select min(cort_level) from cortisolLevels where user_id = \(id);"
        var queryStatement: OpaquePointer? = nil
        var limits = [String: Double]()
        if sqlite3_prepare_v2(db, getMaxString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let max = sqlite3_column_double(queryStatement, 0)
                limits["max"] = max
                print("Query Result:")
                print("\(max)")
            } else {
                print("Max not collected.")
                exit(EXIT_FAILURE)
            }
        } else {
            print("SELECT statement could not be prepared")
            exit(EXIT_FAILURE)
        }
        sqlite3_finalize(queryStatement)
        var queryStatement2: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, getMinString, -1, &queryStatement2, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement2) == SQLITE_ROW {
                let min = sqlite3_column_double(queryStatement2, 0)
                limits["min"] = min
                print("Query Result:")
                print("\(min)")
            } else {
                print("Min not collected.")
                exit(EXIT_FAILURE)
            }
        } else {
            print("SELECT statement could not be prepared")
            exit(EXIT_FAILURE)
        }
        sqlite3_finalize(queryStatement2)
        return limits
    }
    
    func stressDateQuery(user_id: Int, stress: Int, view_type: Int, date: Date) -> String {
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
        let stressDateString = "select date_recorded, \(option)(cort_level) from cortisolLevels where date_recorded >= \(date) order by cort_level \(option2);"
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        var date_recorded = df.string(from: Date())
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, stressDateString, -1, &queryStatement, nil) == SQLITE_OK {
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                date_recorded = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                print("Query Result:")
                print("\(date_recorded)")
            } else {
                print("Date not collected.")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return date_recorded
    }
}
