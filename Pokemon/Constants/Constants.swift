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
    static let titleText = UIColor(hex: 0x4F4F4F)
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

struct Types {
    static let bugType      = "bug"
    static let darkType     = "dark"
    static let dragonType   = "dragon"
    static let electricType = "electric"
    static let fairyType    = "fairy"
    static let fightType    = "fight"
    static let fireType     = "fire"
    static let flyingType   = "flying"
    static let ghostType    = "ghost"
    static let grassType    = "grass"
    static let groundType   = "ground"
    static let iceType      = "ice"
    static let normalType   = "normal"
    static let poisonType   = "poison"
    static let psychicType  = "psychic"
    static let rockType     = "rock"
    static let steelType    = "steel"
    static let waterType    = "water"
    static let unknownType  = "unknown"
    static let shadowType   = "shadow"
}
