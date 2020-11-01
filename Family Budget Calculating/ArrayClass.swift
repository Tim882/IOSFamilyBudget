//
//  ArrayClass.swift
//  Family Budget Calculating
//
//  Created by Тимур on 26.09.2018.
//  Copyright © 2018 Luffor. All rights reserved.
//

import Foundation

class ArrayClass {
    var sum: String
    var comment: String
    var category: String
    var date: String
    init() {
        sum = ""
        category = ""
        comment = ""
        date = ""
    }
    init(date1: String, category1: String, sum1: String, comment1: String) {
        date = date1
        category = category1
        sum = sum1
        comment = comment1
    }
}
