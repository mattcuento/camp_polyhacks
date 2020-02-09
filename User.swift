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
    
    /* For Further Development
    private var dailyReport: Report
    private var monthlyReport: Report
    private var yearlyReport: Report*/
    
    // Default Constructor
    init(id: Int64, email: String, password: String, firstName: String, lastName: String){
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
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
    
    
}
// Equatable method (Basically Swift's version of .equals)
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool{
        return (lhs.getId() == rhs.getId()) && (lhs.getEmail() == rhs.getEmail()) &&
            (lhs.getPassword() == rhs.getPassword()) && (lhs.getFirstName() == rhs.getFirstName()) && (lhs.getLastName() == rhs.getLastName())
    }
}
