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
        print("Successful operation")
    }
    
    //1 day, 2 week, 3 month
    func translateToTime(viewType: Int) -> String {
        let now = Date()
        var dateComponent = DateComponents()
        switch viewType {
        case 1:
            print("Here")
           // dateComponent.days = -1
            //translate to day
            // Date "2/9/2020 00:00"
        case 2:
            print("Here")
            //dateComponent.days = -7
            //translate to week
            // Date "2/2/2020 20:24"
        case 3:
            print("Here")
            //dateComponent.months = -1
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
}

