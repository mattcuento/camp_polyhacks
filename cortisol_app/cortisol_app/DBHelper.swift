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
        let cortisolLevelsTable = "create table if not exists cortisolLevels (id int primary key, time_recorded varchar(50), day_recorded varchar(50), cort_level double, heart_rate int, activity int, report_id int);"
        let activitiesTable = "create table if not exists activities (id int primary key, activity varchar(80), positivity boolean);"
        let sevenDayReportsTable = "create table if not exists sevenDayReports(id int primary key, cort_avg double, num_peaks int);"
        let reportMetas = "create table if not exists reportMetas(id int primary key, descriptor varchar(80));"
        let cortisolLevelsArchive = "create table if not exists cortisolLevelsArchive(id int primary key, archive_id int, time_recorded varchar(50), day_recorded varchar(50), cort_level double, heart_rate int, activity int, report_id int);"
        let sevenDayReportArchives = "create table if not exists sevenDayReportsArchive(id int primary key, archive_id int, cort_avg double, num_peaks int);"
        let usersTable = "create table if not exists Users(int id primary key, email varchar(80), fname varchar(50), lname varchar(80), password varchar(100));"
        let tableCreation: [String] = [cortisolLevelsTable, activitiesTable, sevenDayReportsTable, reportMetas, cortisolLevelsArchive, sevenDayReportArchives, usersTable]
        for currentQuery in tableCreation {
            var createTableStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, currentQuery, -1, &createTableStatement, nil) == SQLITE_OK
            {
                if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("Table created.")
                } else {
                    print("Table not be created.")
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
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM users WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
