//
//  Constants.swift
//  Pokemon
//
//  Created by Deonte on 10/13/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit


let pokemonCellID = "pokemonCellId"


extension UIColor {
    static let mainTintColor = UIColor(hex: 0xFF3B30)
    static let mainBackgroundColor = UIColor(hex: 0xFFFFFF)
    static let titleText = #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1) //UIColor(hex: 0x4F4F4F)
    static let subtitleText = UIColor(hex: 0xA4A4A4)
    static let blueTitle = UIColor(hex: 0x559EDF)
}


protocol Formattable {
    func format(pattern: String) -> String
}
extension Formattable where Self: CVarArg {
    func format(pattern: String) -> String {
        return String(format: pattern, arguments: [self])
    }
}
extension Int: Formattable { }
extension Double: Formattable { }
extension Float: Formattable { }


