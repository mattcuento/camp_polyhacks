//
//  ViewController.swift
//  cortisol_app
//
//  Created by Matt Cuento on 2/8/20.
//  Copyright © 2020 Rolling Thunder. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    var db:DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = 1
        let email = "mcuento@calpoly.edu"
        let password = "xtxtxt"
        let firstName = "Matt"
        let lastName = "Cuento"
        var user = User(id: Int64(id), email: email, password: password, firstName: firstName, lastName: lastName)
        print("Successful operation")
        let max_cort = 268.6
        let min_cort = 186.9
        var reportDaily = Report(id: 1, user_id: id, max_cort: max_cort, min_cort: min_cort, view_type: 1)
        var reportWeekly = Report(id: 2, user_id: id, max_cort: max_cort, min_cort: min_cort, view_type: 2)
        var reportMonthly = Report(id: 3, user_id: id, max_cort: max_cort, min_cort: min_cort, view_type: 3)
    }
}

