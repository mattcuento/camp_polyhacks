//
//  User.swift
//  cortisol_app
//
//  Created by Shah Samiur Rahman on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import Foundation

class User{
    // User Class
    private var id: Int64
    private var email: String
    private var password: String
    private var firstName: String
    private var lastName: String
    //private var reports: [Report]
    //private var activities: [Activity]
    
    // Default Constructor
    init(id: Int64, email: String, password: String, firstName: String, lastName: String){
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        //let day = Report(self.id, 1) //TODO add parameters
        //let week = Report(self.id, 1) //TODO add parameters
        //let month = Report(self.id, 1) //TODO add parameters
        //self.reports = [day, week, month]
        //self.activities = readActivities(self.id) //TODO check
    }
    
    // Getter Functions
    func getId() -> Int64{
        return self.id
    }
    func getEmail() -> String{
        return self.email
    }
    func getPassword() -> String{
        return self.password
    }
    func getFirstName() -> String{
        return self.firstName
    }
    func getLastName() -> String{
        return self.lastName
    }
    
    // Setter Functions
    func setEmail(email: String){
        self.email = email
    }
    func setPassword(password: String){
        self.password = password
    }
    func setFirstName(firstName: String){
        self.firstName = firstName;
    }
    func setLastName(lastName: String){
        self.lastName = lastName
    }
    // Equatable method (Basically Swift's version of .equals)
    /*extension User: Equatable {
        static func == (lhs: User, rhs: User) -> Bool{
            
        }
    }*/
    
}
