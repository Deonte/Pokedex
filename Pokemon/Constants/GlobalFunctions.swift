//
//  GlobalFunctions.swift
//  Pokemon
//
//  Created by Deonte on 10/20/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import Foundation


func replace(if string: String,  contains: String, with: Any) -> String {
  
    if string.contains(contains) {
        let newString = string.replacingOccurrences(of: contains, with: "\(with)")
        return newString
    } else {
        return string
    }
}

