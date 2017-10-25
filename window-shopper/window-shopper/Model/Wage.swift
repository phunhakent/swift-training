//
//  Wage.swift
//  window-shopper
//
//  Created by Kent Nguyen on 10/25/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import Foundation

class Wage {
    class func getHours(forWage wage: Double, andPrice price: Double) -> Int {
        return Int( ceil(price / wage))
    }
}
