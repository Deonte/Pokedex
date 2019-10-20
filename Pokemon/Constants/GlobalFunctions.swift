//
//  GlobalFunctions.swift
//  Pokemon
//
//  Created by Deonte on 10/20/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import Foundation


func replace(if string: String,  contains: String, with int: Int) -> String {
  
    if string.contains(contains) {
        let newString = string.replacingOccurrences(of: contains, with: "\(int)")
        return newString
    } else {
        return string
    }
}

