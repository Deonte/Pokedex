//
//  TypeColors.swift
//  Pokemon
//
//  Created by Deonte on 10/16/19.
//  Copyright © 2019 Deonte. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(hex: UInt32, alpha: Double = 1.0) {
        self.init(red: CGFloat(Double((hex & 0xFF0000) >> 16) / 255.0),
                  green: CGFloat(Double((hex & 0xFF00) >> 8) / 255.0),
                  blue: CGFloat(Double(hex & 0xFF) / 255.0),
                  alpha: CGFloat(alpha))
    }
}

struct TypeColors {
    static let bugType      = UIColor(hex: 0x9DC130)
    static let darkType     = UIColor(hex: 0x5F606D)
    static let dragonType   = UIColor(hex: 0x0773C7)
    static let electricType = UIColor(hex: 0xEDD53F)
    static let fairyType    = UIColor(hex: 0xEF97E6)
    static let fightType    = UIColor(hex: 0xD94256)
    static let fireType     = UIColor(hex: 0xF8A54F)
    static let flyingType   = UIColor(hex: 0x9BB4E8)
    static let ghostType    = UIColor(hex: 0x6970C5)
    static let grassType    = UIColor(hex: 0x5DBE62)
    static let groundType   = UIColor(hex: 0xD78555)
    static let iceType      = UIColor(hex: 0x7ED4C9)
    static let normalType   = UIColor(hex: 0x9A9DA1)
    static let poisonType   = UIColor(hex: 0xB563CE)
    static let psychicType  = UIColor(hex: 0xF87C7A)
    static let rockType     = UIColor(hex: 0xCEC18C)
    static let steelType    = UIColor(hex: 0x5596A4)
    static let waterType    = UIColor(hex: 0x559EDF)
    static let unknownType  = UIColor(hex: 0x6D6D6D)
    static let shadowType   = UIColor(hex: 0x131313)
}

